resource aws_cloudwatch_event_rule "cognito_metric_post_rule_1" {
  name                = "${var.environment}-cognito-metric-post-rule"
  description         = "${var.environment} cognito metric post periodical"
  schedule_expression = "rate(5 minutes)"

  tags = {
    Name = "${var.environment}-cognito-metric-post-rule"
    Env  = var.environment
  }
}

resource aws_cloudwatch_event_target "cognito_metric_post_target_1" {
  rule      = aws_cloudwatch_event_rule.cognito_metric_post_rule_1.name
  arn       = module.lambda_cognito_metric_invoker.lambda_function_arn
  input     = "{\"environment\":\"${var.environment}\",\"mackerel_service\":\"${var.service_name}\"}"
}
