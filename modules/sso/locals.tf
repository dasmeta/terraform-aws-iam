locals {
  # all_users = flatten([
  #   for group_users in var.users : [
  #     for user in group_users.users : {
  #       user_name    = user.user_name
  #       email        = user.user_name
  #       display_name = user.display_name
  #       name = user.name != null ? {
  #         given_name  = user.name.given_name
  #         family_name = user.name.family_name
  #       } : null
  #     }
  #   ]
  # ])

  all_groups = [for item in var.associations : {
    name        = item.group
    description = lookup(item, "group_description", null)
  }]
  #   all_groups = distinct([
  #     for groups in var.groups_users : {
  #       name        = groups.group_name
  #       description = groups.group_description
  #     }
  #   ])
  group_memberships = merge([
    for user in var.users : { for group in user.groups :
      "${group}|${user.user_name}" => {
        group_name = group
        user_name  = user.user_name
      }
    }
  ]...)
}

# variable "users" {
#   type = list(object({
#     users = object({
#       groups        = list(string)
#       user_name    = string # should be the email of the user
#       display_name = string
#       name = optional(object({
#         given_name  = string
#         family_name = string
#       }), null)
#     })
#   }))
# }
