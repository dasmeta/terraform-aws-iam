locals {
  all_users = flatten([
    for group_users in var.groups_users : [
      for user in group_users.users : {
        user_name    = user.user_name
        email        = user.user_name
        display_name = user.display_name
        name = user.name != null ? {
          given_name  = user.name.given_name
          family_name = user.name.family_name
        } : null
      }
    ]
  ])

  all_groups = [
    for groups in var.groups_users : {
      name        = groups.group_name
      description = groups.group_description
    }
  ]
  group_memberships = merge([
    for group in var.groups_users : { for user in group.users :
      "${group.group_name}|${user.user_name}" => {
        group_name = group.group_name
        user_name  = user.user_name
      }
    }
  ]...)
}
