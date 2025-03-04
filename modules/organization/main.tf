# Enable AWS Organizations
resource "aws_organizations_organization" "main" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com",
    "securityhub.amazonaws.com",
    "guardduty.amazonaws.com"
  ]

  feature_set = "ALL"
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}

# Create Organizational Units
resource "aws_organizations_organizational_unit" "departments" {
  for_each  = var.organizational_units
  name      = each.key
  parent_id = aws_organizations_organization.main.roots[0].id
}

# Create accounts
resource "aws_organizations_account" "accounts" {
  for_each = var.accounts

  name      = each.value.name
  email     = each.value.email
  parent_id = aws_organizations_organizational_unit.departments[each.value.ou].id

  role_name = "OrganizationAccountAccessRole"
  
  tags = merge(
    var.common_tags,
    each.value.tags,
    {
      Department = each.value.ou
    }
  )
}
