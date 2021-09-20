module "lambda_cognito_metric_invoker" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = ""
  handler       = "main.post_cognito_sign_in_stats"
  runtime       = "python3.9"

  role_name = "lambdaCognitoMetricInvokerRole"
  attach_policy_jsons = true
  number_of_policy_jsons = 2
  policy_jsons = [
    data.aws_iam_policy_document.cw_get_metric_policy_document.json,
    data.aws_iam_policy_document.ssm_get_parameter_policy_document.json
  ]

  allowed_triggers = {
    Rule1 = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.cognito_metric_post_rule_1.arn
    }
  }

  source_path = "../src"

  tags = {
    Name = var.function_name
  }
}
