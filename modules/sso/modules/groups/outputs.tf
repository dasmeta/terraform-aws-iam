output "groups" {
  value = { for k, v in aws_identitystore_group.this : v.display_name =>
    v.group_id
  }
}
