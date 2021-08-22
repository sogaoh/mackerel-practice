# mackerel-practice/terraform-provider/monitor/external

terraform-provider-mackerel で URL外形監視を 2 秒(+α)で始める の関連コード

refs
- [terraform-provider-mackerel で URL外形監視を 2 秒(+α)で始める](https://zenn.dev/sogaoh/articles/21-05-09-02a760159e89c8cf5880)


## Pre-Requirements
- Local
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 0.15.3 [^1]

- Sign up https://mackerel.io/
    - confirm API key

- Decide monitoring target site
    - ex. https://ant-in-giant.github.io/slide/

- Place `terraform-provider-mackerel` binary [^2]
    - download from [mackerelio-labs/terraform-provider-mackerel/releases](https://github.com/mackerelio-labs/terraform-provider-mackerel/releases)
    - unzip downloaded zip
    - place binary (terraform-provider-mackerel_vX.X.X) to [^3]
        - `~/.terraform.d/plugins/registry.terraform.io/mackerel/mackerel/X.X.X/darwin_amd64/` (macOS)
        - `${WorkingDirectory}/.terraform/plugins/registry.terraform.io/mackerel/mackerel/X.X.X/darwin_amd64/`


## Execution procedure
```
cd ${your_appropriate_directory}
git clone https://github.com/sogaoh/mackerel-practice.git
```

```
cd mackerel-practice/terraform-provider/monitor/external
(vi terraform.tfvars)   # set var.api_key
(vi monitor-external)   # adjust parameters

terraform init -plugin-dir=${HOME}/.terraform.d/plugins
terraform plan
terraform apply
```


# Footnote
[^1]: バージョン切り替え時は .terraform-version の記述を変更して terraform init し直す
[^2]: registry.terraform.io に登録されたら踏まなくて良い手順となる予想
[^3]: refs https://www.terraform.io/docs/cli/config/config-file.html#provider-installation
