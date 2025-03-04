# AWS Organizations Terraform Module

This module manages AWS Organizations, creating organizational units (OUs) and member accounts with proper structure and governance.

## Features

- Creates and configures AWS Organizations
- Enables key AWS services integration
- Creates organizational units (OUs)
- Automates account creation
- Implements tags and naming conventions
- Enables service control policies

## Usage

```hcl
module "organization" {
  source = "../../modules/organization"

  organizational_units = toset([
    "Production",
    "Development",
    "Security"
  ])

  accounts = {
    "account-001" = {
      name  = "Production-Account"
      email = "aws.prod@example.com"
      ou    = "Production"
      tags  = {
        Environment = "Production"
      }
    }
  }

  common_tags = {
    ManagedBy = "Terraform"
    Owner     = "Cloud Team"
  }
}
```

## Requirements

- AWS Organizations enabled in management account
- Appropriate IAM permissions
- Valid email addresses for member accounts
- AWS account limit increase (if creating many accounts)

## Input Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| organizational_units | List of OUs to create | set(string) | - |
| accounts | Map of accounts to create | map(object) | - |
| common_tags | Common tags for all accounts | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| organization_id | AWS Organizations ID |
| organizational_unit_ids | Map of OU names to their IDs |
| account_ids | Map of account names to their IDs |

## Implementation Steps

1. Enable AWS Organizations
2. Create organizational units
3. Create member accounts
4. Apply tags and policies
5. Configure service access

## Service Integrations

The module enables these AWS services:
- AWS CloudTrail
- AWS Config
- AWS Single Sign-On
- AWS SecurityHub
- AWS GuardDuty

## Account Creation Process

1. Validates email addresses
2. Creates account in specified OU
3. Sets up IAM role for access
4. Applies tags and policies
5. Enables required services

## Best Practices

1. Use unique email addresses for each account
2. Implement proper naming conventions
3. Apply appropriate tags
4. Use service control policies
5. Regular security reviews

## Security Considerations

- Enable MFA for root accounts
- Implement strict password policies
- Use service control policies
- Monitor account activity
- Regular compliance checks

## Troubleshooting

Common issues and solutions:
1. Account creation failures
   - Check email uniqueness
   - Verify permissions
   - Check account limits

2. Service enablement issues
   - Verify service principals
   - Check IAM permissions
   - Review error logs

## Maintenance

Regular tasks:
1. Review account configurations
2. Update service control policies
3. Audit account access
4. Update tags and metadata
5. Monitor service integrations

## Cost Considerations

- Account creation is free
- Service usage costs vary
- Monitor enabled services
- Review resource usage

## Compliance

The module helps maintain:
- Security best practices
- Regulatory compliance
- Resource governance
- Access control

## Support

For issues:
1. Check AWS Organizations documentation
2. Review Terraform logs
3. Contact AWS support
4. Consult cloud team
