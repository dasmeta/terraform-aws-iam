module "groups" {
  source = "./../"

  groups = [
    {
      name        = "Test group1",
      description = "Group for testing"
    }
  ]
}

output "groups" {
  value = module.groups.groups
}
