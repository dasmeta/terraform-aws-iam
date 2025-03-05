# output "users" {
#   value = { for user, user_obj in var.users : user_obj.user_name => {
#     user_id = (aws_identitystore_user.users[user].user_id)
#   } }
# }
