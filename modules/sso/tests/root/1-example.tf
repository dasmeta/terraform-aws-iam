module "this" {
  source = "../.."

  account = "prod"
  applications = [{
    "name" : "vpn"
  }]
  associations = [{
    "group" : "admin", "permission-set" : "admin"
  }]
  domain = "test"
  groups = [{
    "applications" : ["vpn"],
    "name" : "admins",
    "permission-set" : "admin"
    },
    {
      "applications" : ["vpn"],
    "name" : "devs" },
    {
      "applications" : ["vpn"],
    "name" : "read-only" },
    {
      "applications" : ["vpn"],
      "name" : "billing"
  }]
  identity_source = {}
  permission-sets = [
    { "name" : "billing" },
    { "name" : "dev" },
    { "name" : "read-only" },
    { "name" : "admin" }
  ]
  providers = { "aws" : "aws" }
}
