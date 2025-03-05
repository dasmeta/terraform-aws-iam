data "aws_ssoadmin_instances" "this" {}

data "aws_identitystore_groups" "groups" {
  identity_store_id = data.aws_ssoadmin_instances.this.identity_store_ids[0]

}
