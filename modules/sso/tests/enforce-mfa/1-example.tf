module "this" {
  source      = "../.."
  enforce_mfa = true

  associations = [
    {
      group  = "Administrators", //Group name
      policy = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    },
    {
      group  = "Developers", //Group name
      policy = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
  ]

  groups_users = [
    {
      group_name        = "test-group1"
      group_description = "this is the test group1"
      users = [
        {
          user_name    = "JohnWick@dasmeta.com"
          display_name = "JohnWick"
          name = {
            given_name  = "John"
            family_name = "Wick"
          }
        },
        {
          user_name    = "JackReaper@dasmeta.com"
          display_name = "JackReaper"
          name = {
            given_name  = "Jack"
            family_name = "Reaper"
          }
        }
      ]
    },
    {
      group_name        = "test-group2"
      group_description = "this is the test group2"
      users = [
        {
          user_name    = "CountDooku@dasmeta.com"
          display_name = "CountDooku"
          name = {
            given_name  = "Count"
            family_name = "Dooku"
          }
        }
      ]

    }
  ]


}
