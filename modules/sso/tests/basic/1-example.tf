module "this" {
  source = "../.."

  associations = [
    {
      group  = "Administrators", //Group name
      policy = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    },
    # {
    #   group  = "Developers", //Group name
    #   policy = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    # }
    {
      group  = "Developers", //Group name
      policy = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
  ]
}
