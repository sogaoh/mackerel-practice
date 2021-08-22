# @see https://registry.terraform.io/providers/mackerelio-labs/mackerel/latest/docs/resources/monitor

resource mackerel_monitor "external_stns_api_endpoint" {
  is_mute = false

  //基本設定
  name = "[serverless-stns] ExternalStnsApiEndpoint"
  memo = ""

  external {
    //監視対象
    method = "GET"
    url    = "${var.stns_api_endpoint}/users"

    //オプション
    service = mackerel_service.serverless_stns.name

    response_time_warning  = 10000     //ms
    response_time_critical = 30000     //ms

    //通知の再送間隔
    response_time_duration = 3         //min

    //リクエストヘッダ
    headers = {
        Authorization = "token ${var.stns_auth_token}"
    }

    //レスポンスボディをチェックする
    #contains_string = "{\"message\":\"Unauthorized\"}"
    contains_string = "{\"name\":\"sogaoh\","

    //証明書の有効期限の監視
    certification_expiration_warning  = 30  //day
    certification_expiration_critical = 10  //day
  }
}
