variable "associations" {
  type = any
}

variable "account_id" {
  type    = string
  default = ""
}

variable "enforce_mfa" {
  type    = bool
  default = true
}

variable "groups_users" {
  type = list(object({
    group_name        = string
    group_description = optional(string, null)
    users = list(object({
      user_name    = string # should be the email of the user
      display_name = string
      name = optional(object({
        given_name  = string
        family_name = string
      }), null)
    }))
  }))
}
