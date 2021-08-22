# mackerel-practice/terraform-provider/monitor/service_metric

自宅のグローバルIPが変わるのを監視する の関連コード

refs
- [Mackerelで自宅のグローバルIPが変わるのを監視する方法 (1)](https://zenn.dev/sogaoh/articles/21-07-22-1e5495c4215df0)


## Pre-Requirements
- Local
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 1.0.3 [^1]

- Sign up https://mackerel.io/
    - confirm API key

- (Set up service metric posting.)



## Execution procedure
```
cd ${your_appropriate_directory}
git clone https://github.com/sogaoh/mackerel-practice.git
```

```
cd mackerel-practice/terraform-provider/monitor/service_metric
(vi terraform.tfvars)         # set var.api_key, var.int_ip, var.service
(vi monitor-service_metric)   # adjust parameters

terraform init
terraform plan
terraform apply
```


# Footnote
[^1]: バージョン切り替え時は .terraform-version の記述を変更して terraform init し直す
