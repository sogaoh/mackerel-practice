resource "mackerel_monitor" "service-metric_global-ip-change-upper" {
    is_mute = false

    //基本設定
    name = "global_ip.ip2int (↑)"
    memo = "(2021/7/15〜) \n(value of [int <- ip])\n(IPv4 address)"

    service_metric {
        service = var.service
        metric   = "global_ip.ip2int"

        //閾値
        operator = ">"
        critical  = var.int_ip
        duration = 1

        //アラート発生までの最大試行回数
        max_check_attempts = 1
    }

    //通知の再送間隔
    notification_interval = 90
}

resource "mackerel_monitor" "service-metric_global-ip-change-lower" {
  is_mute = false

  //基本設定
  name = "global_ip.ip2int (↓)"
  memo = "(2021/7/15〜) \n(value of [int <- ip])\n(IPv4 address)"

  service_metric {
    service = var.service
    metric   = "global_ip.ip2int"

    //閾値
    operator = "<"
    warning  = var.int_ip
    duration = 1

    //アラート発生までの最大試行回数
    max_check_attempts = 1
  }

  //通知の再送間隔
  notification_interval = 90
}
