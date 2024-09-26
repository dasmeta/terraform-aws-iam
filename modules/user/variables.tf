variable "name" {
  type        = string
  description = "Role name"
}

variable "description" {
  type        = string
  description = "Role description"
}

variable "policy" {
  type = list(object({
    actions   = list(string)
    resources = list(string)
  }))
  description = "AWS role assigne policy"
}
