# mackerel-practice

## blogged

- [aws-01](aws-01)
    - AWSインテグレーションでRDS->ESのデータ転送をモニタリングする の環境構築コード
- [raspi-01](raspi-01)
    - RaspberryPi起点で自宅インターネット回線モニタリング作戦 の環境構築コード  
      ＋ 自宅のグローバルIPが変わるのを監視する用のコード
- [google-01](google-01)
    -  GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する の関連コード


### terraform-provider-mackerel Related
uses https://github.com/mackerelio-labs/terraform-provider-mackerel

- [monitor/external : URL外形監視](terraform-provider/monitor/external)
    - terraform-provider-mackerel で URL外形監視を 2 秒(+α)で始める の関連コード
- [monitor/service_metric : サービスメトリック監視](terraform-provider/monitor/service_metric)
    - 自宅のグローバルIPが変わったのを検知して通知する 設定コード


## WIP

- [azure-01](azure-01)
    - Azureインテグレーションを利用してモニタリングする の環境構築コード
