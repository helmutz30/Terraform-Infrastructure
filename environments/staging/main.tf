provider "aws" {
  region = "us-east-1"
  alias  = "staging"
  # Assume role for staging account
  assume_role {
    role_arn = "arn:aws:iam::${var.staging_account_id}:role/TerraformRole"
  }
}

module "vpc_staging" {
  source = "../../modules/vpc"
  providers = {
    aws = aws.staging
  }

  environment          = "staging"
  vpc_cidr            = "192.168.0.0/16"
  public_subnet_cidrs = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnet_cidrs = ["192.168.3.0/24", "192.168.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  bastion_key_name    = "staging-bastion-key"

  tags = {
    Account     = "Staging"
    CostCenter  = "DevOps"
    Project     = "Infrastructure"
  }
}
