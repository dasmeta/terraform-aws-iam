data "aws_caller_identity" "current" {}

module "permission_sets" {
  source   = "./permission-sets"
  for_each = { for item in var.associations : item.group => item }

  permission_sets = [
    {
      name               = each.value.group
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
  # source   = "./account-assignments"
  source  = "cloudposse/sso/aws//modules/account-assignments"
  version = "0.7.1"

  for_each = { for item in var.associations : item.group => item }

  account_assignments = [
    {
      account             = var.account_id == "" ? lookup(each.value, "account_id", data.aws_caller_identity.current.account_id) : var.account_id,
      permission_set_arn  = module.permission_sets["${each.value.group}"].permission_sets["${each.value.group}"].arn,
      permission_set_name = "${each.value.group}",
      principal_type      = "GROUP",
      principal_name      = "test"
    },
  ]
}

output "permission_sets" {
  value = module.permission_sets["PSet-AWSMarketplaceFullAccess"].permission_sets["PSet-AWSMarketplaceFullAccess"].arn
}
