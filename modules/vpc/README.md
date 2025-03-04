# AWS VPC Terraform Module

This module creates a complete VPC infrastructure with public and private subnets, NAT Gateway, Internet Gateway, route tables, and a bastion host.

## Features

- VPC with DNS support
- Public and private subnets across multiple availability zones
- Internet Gateway for public subnets
- NAT Gateway for private subnet internet access
- Network ACLs for both public and private subnets
- Bastion host in public subnet with VPN-restricted access
- Configurable CIDR blocks and tags

## Usage

```hcl
module "vpc" {
  source = "../../modules/vpc"

  environment          = "dev"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  bastion_key_name    = "my-key-pair"
  vpn_cidr            = "172.16.0.0/16"  # Your corporate VPN CIDR
  
  tags = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
```

## Requirements

- AWS provider 5.0 or later
- Terraform 1.2.0 or later
- Valid key pair for bastion host
- Corporate VPN with static CIDR

## Input Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| environment | Environment name | string | - |
| vpc_cidr | CIDR block for VPC | string | - |
| public_subnet_cidrs | CIDR blocks for public subnets | list(string) | - |
| private_subnet_cidrs | CIDR blocks for private subnets | list(string) | - |
| availability_zones | List of availability zones | list(string) | - |
| bastion_instance_type | Instance type for bastion host | string | "t2.micro" |
| bastion_key_name | Key pair name for bastion host | string | - |
| vpn_cidr | CIDR block for corporate VPN | string | - |
| tags | Additional tags for all resources | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| vpc_cidr | CIDR block of the VPC |
| public_subnet_ids | List of IDs of public subnets |
| private_subnet_ids | List of IDs of private subnets |
| nat_gateway_id | ID of the NAT Gateway |
| internet_gateway_id | ID of the Internet Gateway |
| bastion_public_ip | Public IP of the bastion host |
| bastion_private_ip | Private IP of the bastion host |

## Resource Creation

1. VPC with DNS support enabled
2. Internet Gateway attached to VPC
3. Public subnets with route to Internet Gateway
4. Private subnets with route to NAT Gateway
5. NAT Gateway in first public subnet
6. Network ACLs for public and private subnets
7. Security group for bastion host
8. Bastion host instance

## Security Considerations

- Bastion host is accessible via SSH (port 22) only from the corporate VPN CIDR
- Private subnets can only be accessed through the bastion host
- All resources are tagged for better management
- Network ACLs provide additional security layer

## Best Practices

1. Use different CIDR ranges for different environments
2. Implement proper key rotation for bastion host
3. Regular security updates for bastion host
4. Monitor VPC flow logs
5. Use proper naming conventions for resources
6. Regularly review and update VPN CIDR access

## Troubleshooting

1. Ensure AWS credentials are properly configured
2. Check if the specified key pair exists
3. Verify CIDR blocks don't overlap
4. Ensure availability zones are valid for your region
5. Verify VPN CIDR is correctly configured

## Maintenance

- Regularly update the AWS provider
- Keep the bastion host AMI updated
- Review and update security group rules
- Monitor NAT Gateway costs
- Verify VPN connectivity
