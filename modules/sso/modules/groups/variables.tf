variable "groups" {
  type = list(object({
    name        = string
    description = optional(string, null)
  }))
  description = "list of groups"
  default     = []
}
