## This module configures AWS Single Sign-On (SSO). AWS SSO makes it easy to centrally manage access to multiple AWS accounts and business applications and provide users with single sign-on access to all their assigned accounts and applications from one place.

### Usage

This module contains two sub-modules that can be used in conjunction to provision AWS SSO Permission Sets and to
assign AWS SSO Users and Groups to Permissions Sets in accounts.

- [modules/account-assignments](/modules/account-assignments) - a module for assigning groups to permission
sets in particular accounts
- [modules/permission-sets](/modules/permission-sets) - a module for provisioning AWS SSO permission sets

### Example

```hcl
module "sso_setup" {
  source = "./"

  associations = [
    {
      group  = "AWSMarketplaceFullAccess"
      policy = "arn:aws:iam::aws:policy/AWSMarketplaceFullAccess" s"
      // You can set AWS account id (default is current account)
      account_id = ""
    },
    {
      group  = "AmazonGlacierReadOnlyAccess"
      policy = "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
    },
  ]
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_permission_sets"></a> [permission\_sets](#module\_permission\_sets) | ./modules/permission-sets | n/a |
| <a name="module_sso_account_assignments"></a> [sso\_account\_assignments](#module\_sso\_account\_assignments) | ./modules/account-assignments | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_associations"></a> [associations](#input\_associations) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
