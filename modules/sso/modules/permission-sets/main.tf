resource "aws_ssoadmin_permission_set" "this" {

  lifecycle {
    ignore_changes = [
      instance_arn
    ]
  }

  for_each         = local.permission_set_map
  name             = each.key
  description      = each.value.description
  instance_arn     = local.sso_instance_arn
  relay_state      = each.value.relay_state != "" ? each.value.relay_state : null
  session_duration = each.value.session_duration != "" ? each.value.session_duration : null
  tags             = each.value.tags != "" ? each.value.tags : null
}

resource "aws_ssoadmin_permission_set_inline_policy" "this" {

  lifecycle {
    ignore_changes = [
      instance_arn
    ]
  }

  for_each           = local.inline_policies_map
  inline_policy      = each.value
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {

  lifecycle {
    ignore_changes = [
      instance_arn
    ]
  }

  for_each           = local.managed_policy_attachments_map
  instance_arn       = local.sso_instance_arn
  managed_policy_arn = each.value.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.policy_set].arn
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "this" {
  for_each           = local.customer_managed_policy_attachments_map
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.policy_set].arn
  customer_managed_policy_reference {
    name = each.value.policy_name
    path = each.value.policy_path
  }
}
