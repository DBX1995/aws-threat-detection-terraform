resource "aws_sns_topic" "security_alerts" {
  name = "dbx-security-alerts"

  tags = {
    Name        = "DBX Security Alerts"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}

resource "aws_sns_topic_subscription" "security_email" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}