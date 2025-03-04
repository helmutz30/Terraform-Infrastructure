# AWS Multi-Account Infrastructure

This repository contains Terraform configurations for managing a multi-account AWS infrastructure. It includes modules for VPC setup, AWS Organizations management, and security baseline configurations.

## Project Structure

```
.
├── account-setup/          # Main configuration for account creation
├── environments/          # Environment-specific VPC configurations
│   ├── dev/
│   ├── staging/
│   └── prod/
└── modules/              # Reusable Terraform modules
    ├── organization/     # AWS Organizations configuration
    ├── security-baseline/# Security configurations
    └── vpc/             # VPC infrastructure
```

## Prerequisites

1. AWS CLI installed and configured
2. Terraform v1.2.0 or later
3. AWS Management account with appropriate permissions
4. Domain for AWS account email addresses
5. Increased AWS Organizations account limit (default is 10)

## Getting Started

1. Clone this repository
2. Configure AWS credentials for your management account
3. Update the email pattern in `account-setup/main.tf`
4. Initialize and apply the Terraform configurations:

```bash
cd account-setup
terraform init
terraform plan
terraform apply
```

## Modules

- [VPC Module](./modules/vpc/README.md) - Creates VPC infrastructure with public/private subnets
- [Organization Module](./modules/organization/README.md) - Manages AWS Organizations and account creation
- [Security Baseline Module](./modules/security-baseline/README.md) - Implements security controls and monitoring

## Environment Management

Each environment (dev, staging, prod) has its own configuration in the `environments` directory. These use the VPC module with environment-specific settings.

## Security Features

- AWS Organizations with Service Control Policies
- Multi-region CloudTrail logging
- AWS Config rules
- GuardDuty threat detection
- SecurityHub with AWS Foundational Security Best Practices
- IAM password policies
- Encrypted S3 buckets for logs
- Cross-account IAM roles

## Contributing

1. Create a new branch
2. Make your changes
3. Submit a pull request

## License

MIT License

## Support

For support, please contact your cloud team.
