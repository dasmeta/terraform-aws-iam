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
  trust_relationship = []

}
