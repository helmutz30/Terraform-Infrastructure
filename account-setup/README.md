# AWS Account Setup Automation

This directory contains the main configuration for automating the creation and setup of multiple AWS accounts using AWS Organizations and implementing security baselines.

## Overview

This configuration orchestrates:
1. AWS Organizations setup
2. Multiple account creation
3. Security baseline implementation
4. Cross-account access configuration

## Prerequisites

1. AWS Management Account access
2. Terraform v1.2.0 or later
3. AWS CLI configured
4. Domain for account email addresses
5. AWS Organizations limit increase (if creating >10 accounts)
6. Appropriate IAM permissions

## Configuration Structure

```hcl
.
├── main.tf           # Main configuration file
├── variables.tf      # Variable definitions
└── README.md        # This file
```

## Quick Start

1. Update Configuration:
   ```hcl
   # Update in main.tf
   locals {
     account_email_pattern = "aws.%s@yourdomain.com"
     organizational_units = toset([
       "Production",
       "Development",
       "Staging",
       "Security",
       "Shared-Services"
     ])
   }
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Account Creation Process

1. Creates AWS Organization
2. Sets up Organizational Units
3. Creates member accounts
4. Implements security baseline
5. Configures cross-account access

## Security Implementation

- AWS Config enabled
- CloudTrail configured
- GuardDuty enabled
- SecurityHub implemented
- IAM policies set
- Logging configured

## Best Practices

1. Account Management:
   - Use meaningful account names
   - Implement proper tagging
   - Document account purpose
   - Regular access reviews

2. Security:
   - Enable MFA
   - Regular security assessments
   - Monitor account activity
   - Review security findings

3. Cost Management:
   - Monitor service usage
   - Set up budgets
   - Regular cost reviews
   - Resource tagging

## Troubleshooting

1. Account Creation Issues:
   - Verify email uniqueness
   - Check AWS limits
   - Review error messages
   - Verify permissions

2. Security Service Issues:
   - Check service availability
   - Verify role permissions
   - Review CloudWatch logs
   - Check AWS status

## Maintenance

Regular tasks:
1. Update Terraform version
2. Review security findings
3. Update configurations
4. Audit access
5. Update documentation

## Support

For issues:
1. Review AWS documentation
2. Check Terraform logs
3. Contact AWS support
4. Consult cloud team

## Important Notes

1. Account Creation:
   - Takes 5-10 minutes per account
   - Requires unique email per account
   - Limited by AWS quotas
   - Cannot be parallelized

2. Security:
   - Root account credentials
   - IAM user access
   - Service enablement
   - Compliance requirements

3. Costs:
   - Service usage fees
   - Resource costs
   - Data transfer
   - Storage fees

## Contributing

1. Review changes
2. Test locally
3. Update documentation
4. Submit pull request

## License

MIT License
