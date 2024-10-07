# terraform module allows to create aws role with provided policies

## usage example to provide aws eks
```hcl
module "external_dns_role" {
  source  = "dasmeta/iam/aws//modules/role"
  version = "1.2.1"

  name        = "test-role-name"

  policy = [
    {
      actions   = ["route53:ChangeResourceRecordSets"]
      resources = ["arn:aws:route53:::hostedzone/*"]
    },
    {
      actions = [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets",
        "route53:ListTagsForResource"
      ]
      resources = ["*"]
    }
  ]

  trust_relationship = [
    {
      principals = {
        type        = "Service"
        identifiers = ["eks.amazonaws.com"]
      },
      actions = ["sts:AssumeRole"]
    },
    {
      principals = {
        type        = "Federated"
        identifiers = ["arn:aws:iam::<account-id>:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/<oidc-id>"]
      },
      actions = ["sts:AssumeRoleWithWebIdentity"]
      conditions = [{
        type  = "StringEquals"
        key   = "oidc.eks.eu-central-1.amazonaws.com/id/<oidc-id>:aud"
        value = ["sts.amazonaws.com"]
      }]
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
| <a name="input_description"></a> [description](#input\_description) | Role description | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Role name | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | AWS role assigne policy | <pre>list(object({<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_trust_relationship"></a> [trust\_relationship](#input\_trust\_relationship) | AWS role trust relationship | <pre>list(object({<br>    effect     = optional(string, "Allow") # Effect of the policy (Allow or Deny)<br>    actions    = list(string)              # Actions like sts:AssumeRole<br>    principals = any                       # Principals (e.g., AWS, Service, Federated)<br>    conditions = optional(any, [])         # Optional conditions for assume role<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Created role arn |
| <a name="output_assume_role_policy"></a> [assume\_role\_policy](#output\_assume\_role\_policy) | Policy document associated with the role |
| <a name="output_id"></a> [id](#output\_id) | Created role id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
