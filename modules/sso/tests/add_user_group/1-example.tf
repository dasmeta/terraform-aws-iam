module "this" {
  source = "../.."

  associations = [
    {
      group         = "test-group2", //Group name
      policy        = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      inline_policy = ""
    },
    {
      group         = "test-group", //Group name
      policy        = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
      inline_policy = ""
    }
  ]

  users = [
    {
      user_name = "testuser@dasmeta.com"
      groups    = ["test-group", "test-group2"]
      name = {
        given_name  = "test"
        family_name = "user"
      }
    },
    {
      user_name = "JohnWick@dasmeta.com"
      groups    = ["test-group2"]
      name = {
        given_name  = "John"
        family_name = "Wick"
      }
    },
    {
      user_name = "JackReaper@dasmeta.com"
      groups    = ["test-group"]
      name = {
        given_name  = "Jack"
        family_name = "Reaper"
      }
    }
  ]

}
