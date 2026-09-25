resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/dbx-security-audit"
  retention_in_days = 14

  tags = {
    Name        = "DBX CloudTrail Logs"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}