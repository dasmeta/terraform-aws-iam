variable "groups" {
  type = list(object({
    name        = string
    description = string
  }))
  description = "list of groups"
  default     = []
}
