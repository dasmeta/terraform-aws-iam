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
      group  = "Administrators", //Group name
      policy = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    },
    {
      group  = "Developers", //Group name
      policy = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
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
| <a name="module_groups"></a> [groups](#module\_groups) | ./modules/groups | n/a |
| <a name="module_permission_sets"></a> [permission\_sets](#module\_permission\_sets) | ./modules/permission-sets | n/a |
| <a name="module_sso_account_assignments"></a> [sso\_account\_assignments](#module\_sso\_account\_assignments) | ./modules/account-assignments | n/a |
| <a name="module_users"></a> [users](#module\_users) | ./modules/users | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.enforce_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_identitystore_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_associations"></a> [associations](#input\_associations) | n/a | `any` | n/a | yes |
| <a name="input_enforce_mfa"></a> [enforce\_mfa](#input\_enforce\_mfa) | n/a | `bool` | `true` | no |
| <a name="input_groups_users"></a> [groups\_users](#input\_groups\_users) | n/a | <pre>list(object({<br/>    group_name        = string<br/>    group_description = optional(string, null)<br/>    users = list(object({<br/>      user_name    = string # should be the email of the user<br/>      display_name = string<br/>      name = optional(object({<br/>        given_name  = string<br/>        family_name = string<br/>      }), null)<br/>    }))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_memberships"></a> [memberships](#output\_memberships) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
