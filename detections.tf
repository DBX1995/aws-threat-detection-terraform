resource "aws_cloudwatch_log_metric_filter" "cloudtrail_tampering" {
  name           = "CloudTrailTamperingDetected"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventSource = \"cloudtrail.amazonaws.com\") && (($.eventName = \"StopLogging\") || ($.eventName = \"DeleteTrail\") || ($.eventName = \"UpdateTrail\") || ($.eventName = \"PutEventSelectors\")) }"

  metric_transformation {
    name      = "CloudTrailTamperingCount"
    namespace = "DBX/Security"
    value     = "1"
  }
}
resource "aws_cloudwatch_metric_alarm" "cloudtrail_tampering" {
  alarm_name        = "dbx-cloudtrail-tampering-detected"
  alarm_description = "Alerts when CloudTrail configuration is stopped, deleted, or modified."
  namespace         = "DBX/Security"
  metric_name       = "CloudTrailTamperingCount"

  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.security_alerts.arn]

  tags = {
    Name        = "CloudTrail Tampering Detection"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}

resource "aws_cloudwatch_log_metric_filter" "iam_privilege_changes" {
  name           = "IAMPrivilegeChangeDetected"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  pattern = "{ ($.eventSource = \"iam.amazonaws.com\") && (($.eventName = \"AttachRolePolicy\") || ($.eventName = \"PutRolePolicy\") || ($.eventName = \"UpdateAssumeRolePolicy\") || ($.eventName = \"CreatePolicyVersion\") || ($.eventName = \"SetDefaultPolicyVersion\")) }"

  metric_transformation {
    name      = "IAMPrivilegeChangeCount"
    namespace = "DBX/Security"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "iam_privilege_changes" {
  alarm_name        = "dbx-iam-privilege-change-detected"
  alarm_description = "Alerts when sensitive IAM permission or role changes are detected."
  namespace         = "DBX/Security"
  metric_name       = "IAMPrivilegeChangeCount"

  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.security_alerts.arn]

  tags = {
    Name        = "IAM Privilege Change Detection"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}