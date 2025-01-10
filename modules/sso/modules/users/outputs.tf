output "users" {
  value = { for i, user in var.users : user.user_name => {
    user_id = (aws_identitystore_user.users[user.user_name].user_id)
  } }
}
