module "groups" {
  source = "./../"

  groups = [
    {
      name        = "Test group1",
      description = "Group for testing"
    },
    {
      name = "test group",
    }
  ]
}

output "groups" {
  value = module.groups.groups
}
