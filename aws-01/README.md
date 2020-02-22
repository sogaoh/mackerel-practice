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

ansible-playbook ./docker-01_1.yaml -i inventry -e @variables.yaml -u ubuntu -v -C
ansible-playbook ./docker-01_2.yaml -i inventry -e @variables.yaml -u ubuntu -v -C 
ansible-playbook ./docker-01_3.yaml -i inventry -e @variables.yaml -u ubuntu -v -C 

ansible-playbook ./docker-01_1.yaml -i inventry -e @variables.yaml -u ubuntu -vv
ansible-playbook ./docker-01_2.yaml -i inventry -e @variables.yaml -u ubuntu -vv 
ansible-playbook ./docker-01_3.yaml -i inventry -e @variables.yaml -u ubuntu -vv 

rm -f *.retry
```


## Setting Contents

### 01_terraform
#### terraform.tfvars
``` 
region = ${Set Yours}

aws_access_key = ${Set Yours}
aws_secret_key = ${Set Yours}

backend_bucket = ${Set Yours}

myhome_gip = ${Set Yours}  # check http://ifconfig.io/

key_name = ${Set Yours} (ex. id_rsa)
public_key_path = ${Set Yours} (ex. id_rsa.pub)

world_db_user     = ${Set Yours}
world_db_password = ${Set Yours}


mackerel_aws_integration_account_id  = ${Set Yours} 
mackerel_aws_integration_external_id = ${Set Yours}
```

### 02_ansible
### inventry
```
[logstash]
docker-01   ansible_host=${Set public ip}

[logstash:vars]
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=${Set Yours}
ansible_become=yes
ansible_become_user=root
ansible_become_method=enable
```

### variables.yaml
``` 
mackerel_agent_apikey: "${Set Yours}"

rds_endpoint: "${Set Yours}"
rds_user: "${Set Yours}"
rds_password: "${Set Yours}"

es_domain: "${Set Yours}"
es_arn: "${Set Yours}"
es_endpoint: "${Set Yours}"

aws_client_id: "${Set Yours}"
aws_region: "${Set Yours}"
aws_access_key: "${Set Yours}"
aws_secret_key: "${Set Yours}"
```


# Footnote
[^1]: バージョン切り替え時は対象をたとえば tfenv install 0.12.21 でインストールして tfenv use 0.12.21 で切り替える。現在使用中のバージョンは .terraform-version に記述されている。
