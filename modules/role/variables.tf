variable "name" {
  type        = string
  description = "Role name"
}

variable "description" {
  type        = string
  description = "Role description"
  default     = ""
}

variable "policy" {
  type = list(object({
    actions   = list(string)
    resources = list(string)
  }))
  description = "AWS role assigne policy"
}

variable "trust_relationship" {
  type = list(object({
    effect     = optional(string, "Allow") # Effect of the policy (Allow or Deny)
    actions    = list(string)              # Actions like sts:AssumeRole
    principals = any                       # Principals (e.g., AWS, Service, Federated)
    conditions = optional(any, [])         # Optional conditions for assume role
  }))
  description = "AWS role trust relationship"
}
