variable "dev_account_id" {
  description = "AWS Account ID for development environment"
  type        = string
}

variable "prod_account_id" {
  description = "AWS Account ID for production environment"
  type        = string
}

variable "staging_account_id" {
  description = "AWS Account ID for staging environment"
  type        = string
}

variable "corporate_vpn_cidr" {
  description = "CIDR block for corporate VPN"
  type        = string
}
