output "groups" {
  value = { for i, group in var.groups : group.name => {
    group_id = (aws_identitystore_group.this[group.name].group_id)
  } }
}
