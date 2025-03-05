variable "users" {
  type = list(object({
    user_name    = string # should be the email of the user
    groups       = optional(list(string), [])
    display_name = optional(string, null)
    name = object({
      given_name  = string
      family_name = string
    })
    })
  )
  description = "Map describing users and their groups"
  default     = []
}
