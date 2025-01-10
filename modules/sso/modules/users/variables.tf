variable "users" {
  type = list(object({
    user_name    = string
    display_name = string
    name = object({
      family_name = string
      given_name  = string
    })
  }))
  description = "Map of SSO users"
  default     = []
}
