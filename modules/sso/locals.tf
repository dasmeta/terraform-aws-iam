locals {

  all_groups = [for item in var.associations : {
    name        = item.group
    description = lookup(item, "group_description", null)
  }]

  group_memberships = merge([
    for user in var.users : { for group in user.groups :
      "${group}|${user.user_name}" => {
        group_name = group
        user_name  = user.user_name
      }
    }
  ]...)
}
