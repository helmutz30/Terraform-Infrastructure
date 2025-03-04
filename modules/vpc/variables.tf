variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_key_name" {
  description = "Key pair name for bastion host"
  type        = string
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}
