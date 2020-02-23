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
cd ..    # 02_ansible

(vi inventry)
(vi variables.yaml)

ansible-playbook ./docker-01_1.yaml -i "${public_ip},"                    -u ubuntu -v -C
ansible-playbook ./docker-01_2.yaml -i "${public_ip}," -e @variables.yaml -u ubuntu -v -C 
ansible-playbook ./docker-01_3.yaml -i "${public_ip}," -e @variables.yaml -u ubuntu -v -C 

ansible-playbook ./docker-01_1.yaml -i "${public_ip},"                    -u ubuntu -vv
ansible-playbook ./docker-01_2.yaml -i "${public_ip}," -e @variables.yaml -u ubuntu -vv 
ansible-playbook ./docker-01_3.yaml -i "${public_ip}," -e @variables.yaml -u ubuntu -vv 

rm -f *.retry

cd ..   # mackerel-practice
```

### 03.db_data 
データ投入

```
cd 03_db-data

(confirm ~/.ssh/config)

scp ./world.sql.zip docker-01:/home/ubuntu/

ssh docker-01
ubuntu@docker-01:~$ unzip world.sql.zip

ubuntu@docker-01:~$ mysql -h ${rds_endpoint}  world -u ${rds_user} -p < world.sql
Enter password: (input password)
```


確認

``` 
ubuntu@docker-01:~$ mysql -h ${rds_endpoint} world -u ${rds_user} -p
Enter password: (input password)
・・・
mysql> show tables;
+-----------------+
| Tables_in_world |
+-----------------+
| city            |
| country         |
| countrylanguage |
+-----------------+
3 rows in set (0.00 sec)

mysql> SELECT COUNT(*) FROM city;
+----------+
| COUNT(*) |
+----------+
|     4079 |
+----------+
1 row in set (0.01 sec)
```

### 04.Docker(Logstash)
``` 
ssh docker-01
ubuntu@docker-01:~$ git clone https://github.com/sogaoh/mackerel-practice.git

cd mackerel-practice/aws-01/04_docker/

(vi .env)

docker-compose up -d
```

``` 
(kibana) 
https://${es_endpoint}/_plugin/kibana/

(elasticsearch)
https://${es_endpoint}/_cat/indices
```


(probably)

|status1? |status2 |index         |uid |? |? |rows |? |size1 |size2|
|--- |--- |--- |--- | ---| ---| ---| ---| ---| ---| 
|yellow |open |country         |ZDsyvnaXRRq8D3RHmQgLrQ |5 |1 | 239 |0 |343.2kb |343.2kb|
|yellow |open |city            |OnRcrD1jRGG8oNGRcKHBBw |5 |1 |4079 |0 |860.3kb |860.3kb|
|yellow |open |countrylanguage |yL6peO9ITs2kgZ_2MpAk7g |5 |1 | 984 |0 |312.7kb |312.7kb|
|green  |open |.kibana_1       |EwlMn9lnTG2oDuLp1NiiOQ |1 |0 |   1 |0 |  3.8kb |  3.8kb|


## Setting Contents, Resources
### 00.ssh/config
``` 
# docker-01
Host docker-01
  User ubuntu
  Hostname ${Set docker-01 public ip}
  IdentityFile ${Set Yours}
```

### 01.Terraform
#### terraform.tfvars
``` 
region = ${Set Yours}

aws_access_key = ${Set Yours}
aws_secret_key = ${Set Yours}

myhome_gip = ${Set Yours}  # check http://ifconfig.io/

key_name = ${Set Yours} (ex. id_rsa)
public_key_path = ${Set Yours} (ex. id_rsa.pub)

world_db_user     = ${Set Yours}
world_db_password = ${Set Yours}


mackerel_aws_integration_account_id  = ${Set Yours} 
mackerel_aws_integration_external_id = ${Set Yours}
```

### 02.Ansible
### inventory
```
[localhost]
127.0.0.1 ansible_connection=local

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

## 03.DB-data

### MySQL のサンプルDB world.sql の取得元
- https://dev.mysql.com/doc/index-other.html から world database をダウンロード
    - world.sql.zip は 2020/02/22 時点のもの
    

## 04.Docker(Logstash)

### .env
```
TZ=Asia/Tokyo
JDBC_DRIVER_FILENAME=mysql-connector-java-8.0.19.jar
RDS_ENDPOINT=${Set Yours}
RDS_DATABASE=world
RDS_USERNAME=${Set Yours}
RDS_PASSWORD=${Set Yours}
ES_ENDPOINT=${Set Yours}
```

### MySQLのJDBCコネクタ(JDBC Driver for MySQL (Connector/J)) の取得元
- https://www.mysql.com/jp/products/connector/ [^2]
    - Select Operating System では `Platform Independent` を選択した（2020/02/23）


# Footnote
[^1]: バージョン切り替え時は対象をたとえば tfenv install 0.12.21 でインストールして tfenv use 0.12.21 で切り替える。現在使用中のバージョンは .terraform-version に記述されている。  
[^2]: ダウンロードにはOracleアカウントのサインアップが必要になる。
