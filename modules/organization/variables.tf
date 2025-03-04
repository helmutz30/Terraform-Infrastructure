variable "organizational_units" {
  description = "List of organizational units to create"
  type        = set(string)
}

variable "accounts" {
  description = "Map of accounts to create"
  type = map(object({
    name  = string
    email = string
    ou    = string
    tags  = map(string)
  }))
}

variable "common_tags" {
  description = "Common tags for all accounts"
  type        = map(string)
  default     = {}
}
