resource "aws_iam_role" "detection_test" {
  name = "dbx-detection-test-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "DBX Detection Test Role"
    Environment = "Lab"
    Purpose     = "Security Detection Testing"
    ManagedBy   = "Terraform"
  }
}