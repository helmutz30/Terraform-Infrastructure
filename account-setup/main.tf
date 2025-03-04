provider "aws" {
  region = "us-east-1"
  # This should be your management account credentials
}

locals {
  # Generate email addresses for accounts
  account_email_pattern = "aws.%s@yourdomain.com"
  
  # Define your organizational structure
  organizational_units = toset([
    "Production",
    "Development",
    "Staging",
    "Security",
    "Shared-Services"
  ])

  # Define your accounts
  accounts = {
    for i in range(58) : format("account-%03d", i + 1) => {
      name  = format("Account-%03d", i + 1)
      email = format(local.account_email_pattern, format("account-%03d", i + 1))
      ou    = element(tolist(local.organizational_units), i % length(local.organizational_units))
      tags  = {
        AccountNumber = format("%03d", i + 1)
        CreatedBy     = "Terraform"
      }
    }
  }

  common_tags = {
    ManagedBy = "Terraform"
    Owner     = "Cloud Team"
  }
}

# Create organization and accounts
module "organization" {
  source = "../modules/organization"

  organizational_units = local.organizational_units
  accounts            = local.accounts
  common_tags         = local.common_tags
}

# Apply security baseline to each account
module "security_baseline" {
  source = "../modules/security-baseline"
  
  for_each = module.organization.account_ids

  providers = {
    aws = aws.assumed-role
  }

  master_account_id = data.aws_caller_identity.current.account_id
  environment      = each.value.tags["Environment"]
  tags            = local.common_tags
}

# Provider configuration for assuming role in member accounts
provider "aws" {
  alias  = "assumed-role"
  region = "us-east-1"
  
  assume_role {
    role_arn = "arn:aws:iam::${each.value}:role/OrganizationAccountAccessRole"
  }
}

data "aws_caller_identity" "current" {}
