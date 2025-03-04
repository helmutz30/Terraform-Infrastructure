provider "aws" {
  region = "us-east-1"
  alias  = "dev"
  # Assume role for dev account
  assume_role {
    role_arn = "arn:aws:iam::${var.dev_account_id}:role/TerraformRole"
  }
}

module "vpc_dev" {
  source = "../../modules/vpc"
  providers = {
    aws = aws.dev
  }

  environment          = "dev"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  bastion_key_name    = "dev-bastion-key"

  tags = {
    Account     = "Development"
    CostCenter  = "DevOps"
    Project     = "Infrastructure"
  }
}
