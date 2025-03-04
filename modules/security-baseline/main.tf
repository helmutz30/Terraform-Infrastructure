# Enable AWS Config
resource "aws_config_configuration_recorder" "main" {
  name     = "config-recorder"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported = true
    include_global_resources = true
  }
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true
}

# Enable CloudTrail
resource "aws_cloudtrail" "main" {
  name                          = "organization-trail"
  s3_bucket_name               = aws_s3_bucket.cloudtrail.id
  include_global_service_events = true
  is_multi_region_trail        = true
  enable_logging               = true
  
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cloudwatch_role.arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
}

# Enable GuardDuty
resource "aws_guardduty_detector" "main" {
  enable = true
}

# Enable SecurityHub
resource "aws_securityhub_account" "main" {}

# Enable standard security best practices
resource "aws_securityhub_standards_subscription" "aws_foundations" {
  depends_on    = [aws_securityhub_account.main]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"
}

# Create Password Policy
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_numbers               = true
  require_uppercase_characters   = true
  require_symbols               = true
  allow_users_to_change_password = true
  password_reuse_prevention     = 24
  max_password_age             = 90
}

# Create IAM Roles
resource "aws_iam_role" "admin_role" {
  name = "AdminRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.master_account_id
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# S3 Bucket for CloudTrail logs
resource "aws_s3_bucket" "cloudtrail" {
  bucket = "cloudtrail-logs-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# CloudWatch Log Group for CloudTrail
resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/logs"
  retention_in_days = 365
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
