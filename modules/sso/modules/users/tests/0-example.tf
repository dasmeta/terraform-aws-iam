module "test-users" {
  source = "./../"

  users = [
    {
      user_name    = "testuser@dasmeta.com"
      display_name = "Test User"
      name = {
        given_name  = "Test"
        family_name = "User"
      }
    },
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
}

output "module_outs" {
  value = module.test-users.users
}
