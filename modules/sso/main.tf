data "aws_caller_identity" "current" {}

module "permission_sets" {
  source   = "./modules/permission-sets"
  for_each = { for item in var.associations : item.group => item }

  permission_sets = [
    {
      name               = length(each.value.group) < 33 ? "${each.value.group}" : substr("${each.value.group}", 33, 32)
      policy_attachments = lookup(each.value, "policy", [])

      tags             = lookup(each.value, "tags", {})
      description      = lookup(each.value, "description", null)
      relay_state      = lookup(each.value, "relay_state", "")
      inline_policy    = lookup(each.value, "inline_policy", "")
      session_duration = lookup(each.value, "session_duration", "")

      customer_managed_policy_attachments = concat(flatten([for item in lookup(each.value, "custom_policy", []) :
        {
          name = item
          path = "/"
        }
        ]),
        flatten([var.enforce_mfa ? [
          {
            name = aws_iam_policy.enforce_mfa[0].name
            path = "/"
          }
          ] : []]
        )
      )
    }
  ]
}

module "sso_account_assignments" {
  source = "./modules/account-assignments"

  for_each = { for item in var.associations : item.group => item }

  account_assignments = [for item in lookup(each.value, "account_ids", [(var.account_id == "" ? data.aws_caller_identity.current.account_id : var.account_id)]) :
    {
      account             = item,
      permission_set_arn  = module.permission_sets["${each.value.group}"].permission_sets[length(each.value.group) < 33 ? "${each.value.group}" : substr("${each.value.group}", 33, 32)].arn,
      permission_set_name = length(each.value.group) < 33 ? "${each.value.group}" : substr("${each.value.group}", 33, 32)
      principal_type      = "GROUP",
      principal_name      = "${each.value.group}"
    }
  ]

  depends_on = [
    module.permission_sets
  ]
}

module "users" {
  source = "./modules/users"

  users = local.all_users

}

module "groups" {
  source = "./modules/groups"

  groups = local.all_groups
}

resource "aws_identitystore_group_membership" "this" {
  for_each          = local.group_memberships
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = module.groups.groups[each.value.group_name].group_id
  member_id         = module.users.users[each.value.user_name].user_id

}

resource "aws_iam_policy" "enforce_mfa" {
  count = var.enforce_mfa ? 1 : 0
  name  = "SSOEnforceMFA"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect : "Deny",
        Action : "*",
        Resource : "*",
        Condition : {
          Bool : {
            "aws:MultiFactorAuthPresent" : "false"
          }
        },
      },
      {
        Effect : "Allow",
        Action : [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:ResyncMFADevice",
          "iam:ListMFADevices",
          "iam:DeactivateMFADevice"
        ],
        Resource : "arn:aws:iam::*:user/$${aws:username}"
      }
    ]
  })

}
