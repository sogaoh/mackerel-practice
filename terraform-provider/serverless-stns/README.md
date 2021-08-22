# mackerel-practice/terraform-provider/serverless-stns

serverless-stns を監視する の関連コード

<!--
refs
- [serverless-stns を監視する](https://zenn.dev/sogaoh/articles/)
-->

## Pre-Requirements
- Local
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 1.0.5 [^1]
    - install direnv
        - see [https://direnv.net/#getting-started](https://direnv.net/#getting-started)
    - install mkr
        - see [https://mackerel.io/ja/docs/entry/advanced/cli](https://mackerel.io/ja/docs/entry/advanced/cli)

- Sign up https://mackerel.io/
    - confirm API key

- (Set up serverless-stns)



## Execution procedure
```
cd ${your_appropriate_directory}
git clone https://github.com/sogaoh/mackerel-practice.git
```

```
cd mackerel-practice/terraform-provider/serverless-stns
(vi terraform.tfvars)         # set var.api_key, ...
(echo "export MACKEREL_APIKEY=${your_mackerel_api_key}" > mkr/.envrc)

terraform init
terraform plan
terraform apply

(set displayName(s) on Mackerel Manage Screen)
- `stns-api` of API Gateway -> `stns-api-endpoint`
- `stns-api` of Lambda Function -> `stns-api-function`

cd mkr
(direnv allow)
(chmod +x hosts_roleFullNames.sh)
./hosts_roleFullNames.sh
```


# Footnote
[^1]: バージョン切り替え時は .terraform-version の記述を変更して terraform init し直す
