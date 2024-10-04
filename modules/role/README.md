# role

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.awsrole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Role description | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Role name | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | AWS role assigne policy | <pre>list(object({<br/>    actions   = list(string)<br/>    resources = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_trust_relationship"></a> [trust\_relationship](#input\_trust\_relationship) | AWS role trust relationship | <pre>list(object({<br/>    effect     = optional(string, "Allow") # Effect of the policy (Allow or Deny)<br/>    actions    = list(string)              # Actions like sts:AssumeRole<br/>    principals = any                       # Principals (e.g., AWS, Service, Federated)<br/>    conditions = optional(any, [])         # Optional conditions for assume role<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
