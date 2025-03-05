resource "aws_identitystore_user" "users" {
  for_each = { for idx, user in var.users : user.user_name => user }

  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]

  user_name    = each.value.user_name
  display_name = try(each.value.display_name, null) != null ? each.value.display_name : "${each.value.name.given_name} ${each.value.name.family_name}"
  emails {
    value = each.value.user_name
  }
  name {
    given_name  = each.value.name.given_name
    family_name = each.value.name.family_name
  }
}

resource "aws_identitystore_group_membership" "this" {
  for_each          = local.group_memberships
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = local.group_name_to_id[each.value.group_name]
  member_id         = aws_identitystore_user.users[each.value.user_name].user_id
}

locals {
  group_memberships = merge([
    for user in var.users : {
      for group in user.groups :
      "${group}|${user.user_name}" => {
        group_name = group
        user_name  = user.user_name
      }
      if length(group) > 0 && group != ""
    }
  ]...)

  group_names      = distinct(flatten([for user in var.users : user.groups]))
  group_maps       = { for g in data.aws_identitystore_groups.groups.groups : g.display_name => g.group_id }
  group_name_to_id = { for name in local.group_names : name => lookup(local.group_maps, name, null) }
}
