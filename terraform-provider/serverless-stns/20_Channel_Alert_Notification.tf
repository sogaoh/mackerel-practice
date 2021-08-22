# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/channel

resource mackerel_channel "slack_channel_serverless_stns" {
  name = "SlackChannel-serverlessStns"

  slack {
    url = var.slack_webhook_url
    enabled_graph_image = true
    mentions = {
      critical = "@channel"
      warning  = "warn"
      ok       = "ok"
    }
    events = ["alert", "alertGroup"]
  }
}


# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/alert_group_setting

resource mackerel_alert_group_setting "stns_api_error_4xx" {
  name = "[serverless-stns] Stns1Api4xxError"

  role_scopes = [
    "${mackerel_service.serverless_stns.name}:${mackerel_role.api_gateway.name}",
  ]
}

resource mackerel_alert_group_setting "stns_api_error_5xx" {
  name = "[serverless-stns] Stns1Api5xxError"

  role_scopes = [
    "${mackerel_service.serverless_stns.name}:${mackerel_role.api_gateway.name}",
  ]
}

resource mackerel_alert_group_setting "stns_lambda_error" {
  name = "[serverless-stns] Stns2LambdaError"

  role_scopes = [
    "${mackerel_service.serverless_stns.name}:${mackerel_role.lambda_function.name}",
  ]
}

resource mackerel_alert_group_setting "stns_db_error" {
  name = "[serverless-stns] Stns3DbError"

  role_scopes = [
    "${mackerel_service.serverless_stns.name}:${mackerel_role.dynamo_db.name}",
  ]
}


# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/notification_group

resource mackerel_notification_group "notification_group_serverless_stns" {
  name               = "[serverless-stns] to_slack"
  notification_level = "all"

  child_notification_group_ids = [
  ]
  child_channel_ids = [
    mackerel_channel.slack_channel_serverless_stns.id
  ]

  service {
    name = mackerel_service.serverless_stns.name
  }

  monitor {
    id           = mackerel_monitor.external_stns_api_endpoint.id
    skip_default = true
  }
}
