resource "mackerel_monitor" "external_ant-in-giant_github_io" {
    is_mute = false

    //基本設定
    name = "ant-in-giant.github.io"
    memo = ""

    external {
        //監視対象
        method = "GET"
        url    = "https://ant-in-giant.github.io/slide/"

        //オプション
        service = var.external_service

        response_time_warning  = 30000      //ms
        response_time_critical = 120000     //ms

        response_time_duration = 3          //min

        //レスポンスボディをチェックする
        contains_string = "Slide (index)"

        //証明書の有効期限の監視
        certification_expiration_warning  = 30  //day
        certification_expiration_critical = 10  //day
    }
}