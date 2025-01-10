resource "aws_identitystore_user" "users" {
  for_each = { for idx, user in var.users : user.user_name => user }

  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]

  user_name    = each.value.user_name
  display_name = each.value.display_name
  emails {
    value = each.value.user_name
  }
  name {
    given_name  = each.value.name.given_name
    family_name = each.value.name.family_name
  }
}
