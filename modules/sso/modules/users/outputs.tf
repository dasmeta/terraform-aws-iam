output "users" {
  value = { for idx, user in aws_identitystore_user.users : user.display_name => user.id }
}
