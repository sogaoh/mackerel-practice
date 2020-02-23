resource "aws_iam_role" "mackerel-aws-integration-iam-role" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.mackerel_aws_integration_external_id}"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.mackerel_aws_integration_account_id}:root"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  description          = "IAM Role for Mackerel AWS Integration"
  max_session_duration = "3600"
  name                 = var.mackerel_aws_integration_name
  path                 = "/"

  tags = {
    Name = "mackerel-aws-integration-iam-role_practice"
    service = "default"
  }
}
