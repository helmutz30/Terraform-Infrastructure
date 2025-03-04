provider "aws" {
  region = "us-east-1"
  alias  = "prod"
  # Assume role for prod account
  assume_role {
    role_arn = "arn:aws:iam::${var.prod_account_id}:role/TerraformRole"
  }
}

module "vpc_prod" {
  source = "../../modules/vpc"
  providers = {
    aws = aws.prod
  }

  environment          = "prod"
  vpc_cidr            = "172.16.0.0/16"
  public_subnet_cidrs = ["172.16.1.0/24", "172.16.2.0/24"]
  private_subnet_cidrs = ["172.16.3.0/24", "172.16.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  bastion_key_name    = "prod-bastion-key"
  bastion_instance_type = "t3.micro"

  tags = {
    Account     = "Production"
    CostCenter  = "Operations"
    Project     = "Infrastructure"
  }
}
