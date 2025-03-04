# AWS Security Baseline Terraform Module

This module implements a comprehensive security baseline for AWS accounts, including logging, monitoring, and security services configuration.

## Features

- AWS Config setup
- CloudTrail configuration
- GuardDuty enablement
- SecurityHub implementation
- IAM password policies
- CloudWatch logging
- S3 bucket encryption
- Cross-account IAM roles

## Usage

```hcl
module "security_baseline" {
  source = "../../modules/security-baseline"

  master_account_id = "123456789012"
  environment      = "production"
  
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

## Requirements

- AWS provider configured
- Appropriate IAM permissions
- AWS Organizations enabled
- Cross-account access setup

## Input Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| master_account_id | AWS Account ID of the master account | string | - |
| environment | Environment name | string | - |
| tags | Common tags for all resources | map(string) | {} |

## Security Services Configuration

### AWS Config
- Multi-region recording
- Configuration history
- Configuration snapshots
- Compliance rules

### CloudTrail
- Organization-wide logging
- Multi-region trails
- Log file validation
- CloudWatch integration

### GuardDuty
- Threat detection
- Continuous monitoring
- Finding notifications
- Multi-account setup

### SecurityHub
- Security standards
- Compliance checks
- Integration with other services
- Automated assessments

## IAM Configuration

1. Password Policy
   - Minimum length: 14 characters
   - Requires: uppercase, lowercase, numbers, symbols
   - Password expiration: 90 days
   - Password reuse prevention: 24 passwords

2. Cross-Account Roles
   - Admin role creation
   - Least privilege access
   - Role assumption policies
   - Permission boundaries

## Logging and Monitoring

1. CloudWatch
   - Log retention
   - Log groups
   - Metrics
   - Alarms

2. S3 Configuration
   - Bucket encryption
   - Versioning
   - Access logging
   - Lifecycle policies

## Implementation Steps

1. Enable security services
2. Configure logging
3. Set up IAM policies
4. Enable monitoring
5. Configure notifications

## Best Practices

1. Security
   - Regular security assessments
   - Compliance monitoring
   - Access reviews
   - Incident response planning

2. Monitoring
   - Log analysis
   - Alert configuration
   - Performance monitoring
   - Resource tracking

3. Maintenance
   - Regular updates
   - Policy reviews
   - Configuration checks
   - Documentation updates

## Troubleshooting

Common issues:
1. Service enablement failures
   - Check permissions
   - Verify service availability
   - Review error logs

2. Integration issues
   - Check service connections
   - Verify role permissions
   - Review configuration

## Compliance

This module helps maintain:
- AWS Security Best Practices
- CIS Benchmarks
- NIST guidelines
- Industry standards

## Cost Considerations

Monitor costs for:
- CloudTrail logs
- Config recordings
- GuardDuty
- SecurityHub
- S3 storage
- CloudWatch logs

## Regular Maintenance Tasks

1. Weekly
   - Review security findings
   - Check service health
   - Monitor alerts

2. Monthly
   - Security assessment
   - Policy reviews
   - Access audits

3. Quarterly
   - Compliance review
   - Configuration updates
   - Documentation updates

## Support

For assistance:
1. Review AWS documentation
2. Check Terraform logs
3. Contact security team
4. AWS support tickets

## Additional Resources

- AWS Security Documentation
- Terraform AWS Provider
- AWS Security Best Practices
- Compliance Frameworks
