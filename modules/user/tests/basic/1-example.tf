module "iam-user" {
  source        = "../.."
  username      = "sample-user"
  create_policy = true

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "ec2:*",
        "Resource" : "*"
      }
    ]
  })
}
