data "aws_caller_identity" "current" {}

module "permission_sets" {
  source   = "./modules/permission-sets"
  for_each = { for item in var.associations : item.group => item }

  permission_sets = [
    {
      name               = length(each.value.group) < 33 ? "${each.value.group}" : substr("${each.value.group}", 33, 32)
      policy_attachments = [each.value.policy]

      tags             = lookup(each.value, "tags", {})
      description      = lookup(each.value, "description", null)
      relay_state      = lookup(each.value, "relay_state", "")
      inline_policy    = lookup(each.value, "inline_policy", "")
      session_duration = lookup(each.value, "session_duration", "")

      customer_managed_policy_attachments = lookup(each.value, "customer_managed_policy_attachments", [])
    }
  ]
}

module "sso_account_assignments" {
  source = "./modules/account-assignments"

  for_each = { for item in var.associations : item.group => item }

  account_assignments = [for item in lookup(each.value, "account_ids", [(var.account_id == "" ? data.aws_caller_identity.current.account_id : var.account_id)]) :
    {
      account             = item, // lookup(each.value, "account_id", var.account_id == "" ? data.aws_caller_identity.current.account_id : var.account_id),
      permission_set_arn  = module.permission_sets["${each.value.group}"].permission_sets[length(each.value.group) <= 33 ? "${each.value.group}" : substr("${each.value.group}", 33, length(each.value.group))].arn,
      permission_set_name = length(each.value.group) < 33 ? "${each.value.group}" : substr("${each.value.group}", 33, 32)
      principal_type      = "GROUP",
      principal_name      = "${each.value.group}"
    }
  ]

  depends_on = [
    module.permission_sets
  ]
}
