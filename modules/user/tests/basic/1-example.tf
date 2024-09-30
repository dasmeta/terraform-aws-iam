module "iam-user" {
  source        = "../.."
  username      = "sample-user"
  create_policy = true

  policy = [
    {
      actions   = ["ec2:*"]
      resources = ["*"]
    }
  ]
}
