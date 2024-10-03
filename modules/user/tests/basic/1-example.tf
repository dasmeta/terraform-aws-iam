module "iam-user" {
  source        = "../.."
  username      = "sample-user"
  
  policy = [
    {
      actions   = ["ec2:*"]
      resources = ["*"]
      conditions = [{
        test = "StringEquals"
        variable = "ec2:InstanceType"
        values = ["t3.medium", "c5.2xlarge"]
      }]
    }
  ]
}
