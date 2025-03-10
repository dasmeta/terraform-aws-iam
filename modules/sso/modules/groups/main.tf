resource "aws_identitystore_group" "this" {
  for_each          = { for idx, group in var.groups : idx => group }
  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]

  description  = each.value.description != null ? each.value.description : null
  display_name = each.value.name

}
