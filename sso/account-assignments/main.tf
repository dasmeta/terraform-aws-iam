
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = local.assignment_map

  instance_arn       = local.sso_instance_arn
  permission_set_arn = each.value.permission_set_arn

  principal_id   = each.value.principal_type == "GROUP" ? data.aws_identitystore_group.this[each.value.principal_name].id : data.aws_identitystore_user.this[each.value.principal_name].id
  principal_type = each.value.principal_type

  target_id   = each.value.account
  target_type = "AWS_ACCOUNT"
}
