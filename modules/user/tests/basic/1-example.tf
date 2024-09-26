module "iam-user" {
  source = "../.."

  name        = "sample-user"
  description = "Test user"

  policy = [{
    actions   = ["ec2:*"]
    resources = ["*"]
    }
  ]
}
