variable "associations" {
  type = list(object({
    group             = optional(string)
    policy            = optional(list(string))
    tags              = optional(map(any))
    description       = optional(string)
    relay_state       = optional(string)
    inline_policy     = optional(string)
    session_duration  = optional(string)
    custom_policy     = optional(list(any))
    account_id        = optional(string)
    group_description = optional(string)
  }))
}

variable "account_id" {
  type    = string
  default = ""
}

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
