# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/service
# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/service_metadata

resource mackerel_service "serverless_stns" {
  name = "STNS"
  memo = ""
}

resource mackerel_service_metadata "serverless_stns_metadata" {
  service   = mackerel_service.serverless_stns.id
  namespace = var.service_namespace

  metadata_json = jsonencode({
    endpoint = var.stns_api_endpoint
  })
}


# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/role
# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/role_metadata

resource mackerel_role "api_gateway" {
  service = mackerel_service.serverless_stns.name
  name    = "1_ApiGateway"
  memo    = ""
}

resource mackerel_role "lambda_function" {
  service = mackerel_service.serverless_stns.name
  name    = "2_LambdaFunction"
  memo    = ""
}

resource mackerel_role "dynamo_db" {
  service = mackerel_service.serverless_stns.name
  name    = "3_DynamoDb"
  memo    = ""
}
