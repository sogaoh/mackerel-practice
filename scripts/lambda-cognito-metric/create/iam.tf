data aws_iam_policy_document "cw_get_metric_policy_document" {
  statement {
    actions = [
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricData",
      "cloudwatch:DescribeAlarms",
    ]
    resources = [
      "*"
    ]
  }
}

data aws_iam_policy_document "ssm_get_parameter_policy_document" {
  statement {
    actions = [
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "secretsmanager:GetSecretValue",
      "kms:Decrypt"
    ]

    resources = [
      "arn:aws:ssm:*:*:parameter/*/${var.service_name}/*/*",
    ]
  }
}
