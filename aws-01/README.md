# mackerel-practice/aws-01 

AWSインテグレーションでRDS->ESのデータ転送をモニタリングする の環境構築コード

refs 
- Pubs/Mackerel Ambassador (sogaoh) blogs/
    - [AWSインテグレーションでRDS->ESのデータ転送をモニタリングする設定 (1)](https://esa-pages.io/p/sharing/6641/posts/710/45e07a9a796f3deda74a.html) 
    - [[TBD] AWSインテグレーションでRDS->ESのデータ転送をモニタリングする設定 (2)]()
    

## Pre-Requirements
- Local 
    - install awscli
        - refs https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-macos.html
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 0.12.21 [^1]
    - install Ansible
        - [macOS] brew install ansible

- AWS 
    - Account
    - IAM User
        - confirm Access Key (Credential)
    - S3 bucket (see 01_terraform/02_backend.tf)

- Sign up https://mackerel.io/
    - confirm API key 
    - confirm `Mackerel AWS Integration External ID` (see https://mackerel.io/ja/docs/entry/integrations/aws )


## Execution procedure
```
cd ${your_appropriate_directory}
git clone https://github.com/sogaoh/mackerel-practice.git
```

### 01.Terraform
```
cd mackerel-practice/01_terraform
(vi terraform.tfvars)

terraform init
terraform plan
terraform apply

cd ..   # mackerel-practice
```

### 02.Ansible 
```
ansible-galaxy install geerlingguy.docker
ansible-galaxy install mackerelio.mackerel-agent

cd 02_ansible/roles
mv ${/path/to/.ansible}/roles/* ./ 
cd ..

(vi inventry)
(vi variables.yaml)

ansible-playbook ./docker-01.yaml          -i inventry -e @variables.yaml -u ubuntu -v -C
ansible-playbook ./docker-01_mackerel.yaml -i inventry -e @variables.yaml -u ubuntu -v -C 

ansible-playbook ./docker-01.yaml          -i inventry -e @variables.yaml -u ubuntu -vv
ansible-playbook ./docker-01_mackerel.yaml -i inventry -e @variables.yaml -u ubuntu -vv 

rm -f *.retry
```


# Footnote
[^1]: バージョン切り替え時は対象をたとえば tfenv install 0.12.21 でインストールして tfenv use 0.12.21 で切り替える。現在使用中のバージョンは .terraform-version に記述されている。
