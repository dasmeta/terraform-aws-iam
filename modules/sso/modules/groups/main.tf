resource "aws_identitystore_group" "this" {
  for_each = { for i, group in var.groups : group.name => group }

  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]

  description  = each.value.description
  display_name = each.value.name

}
