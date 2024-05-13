module "this" {
  source = "../.."
  associations = [
    {
      group  = "AdministratorAccess",
      policy = "arn:aws:iam::aws:policy/AdministratorAccess"
    },
    {
      group  = "ReadOnlyAccess",
      policy = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    }
  ]
}
