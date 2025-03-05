module "test-users" {
  source = "./../"

  users = [
    {
      user_name    = "testuser@dasmeta.com"
      display_name = "Test User"
      groups       = ["test group"]
      name = {
        given_name  = "Test"
        family_name = "User"
      }
    },
    {
      user_name    = "JohnWick@dasmeta.com"
      display_name = "JohnWick"
      groups       = ["Test group1", "test group"]
      name = {
        given_name  = "John"
        family_name = "Wick"
      }
    },
    {
      user_name    = "jackReaper@dasmeta.com"
      display_name = "JackReaper"
      groups       = ["Test group1"]
      name = {
        given_name  = "Jack"
        family_name = "Reaper"
      }
    },
    {
      user_name    = "hannibal@dasmeta.com"
      display_name = "Hannibal"
      name = {
        family_name = "Leckter"
        given_name  = "Hannibal"
      }
    }
  ]
}

output "module_outs" {
  value = module.test-users.users
}
