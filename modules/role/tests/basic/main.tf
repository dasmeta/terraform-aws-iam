module "test" {
  source = "../../"

  name        = "test"
  description = "test-role"

  policy = [
    {
      actions   = ["s3:*", "s3-object-lambda:*"]
      resources = ["*"]
    },
    {
      actions   = ["sqs:*"]
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
      #   condition = {}
      conditions = [{
        type  = "StringEquals"
        key   = "oidc.eks.eu-central-1.amazonaws.com/id/<oidc-id>:aud"
        value = ["sts.amazonaws.com"]
      }]
    }
  ]
}
