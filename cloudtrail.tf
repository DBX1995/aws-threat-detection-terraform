resource "aws_cloudtrail" "security_audit" {
  name                          = "dbx-security-audit-trail"
  s3_bucket_name                = aws_s3_bucket.security_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cloudwatch.arn

  depends_on = [
    aws_s3_bucket_policy.security_logs,
    aws_iam_role_policy.cloudtrail_cloudwatch
  ]

  tags = {
    Name        = "DBX Security Audit Trail"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}