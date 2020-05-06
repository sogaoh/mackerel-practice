# mackerel-practice/azure-01 

Azureインテグレーションを利用してモニタリングする の環境構築コード

refs 
- Pubs/Mackerel Ambassador (sogaoh) blogs/

## Pre-Requirements
- Local 
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 0.12.24 [^1]
    - install Ansible
        - [macOS] brew install ansible

- Azure
    - Subscription
        - subscription_id
    - ServicePrincipal [^2]
        - client_id  (appId)   
        - client_secret (password) 
        - tenant_id (tenant)    
    - Storage Account
        - (resource group for save tfstate file : see 01_terraform/backend.tf)

- Sign up https://mackerel.io/
    - confirm API key 


## Execution procedure
```
cd ${your_appropriate_directory}
git clone https://github.com/sogaoh/mackerel-practice.git
```

### 01.Terraform
```
cd mackerel-practice/azure-01/01_terraform
(vi terraform.tfvars)

terraform init
terraform plan
terraform apply

cd ..   # mackerel-practice/azure-01
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

ansible-playbook ./sandbox-01_1.yaml -i "${public_ip},"                    -u ${admin_user} --private-key ~/.ssh/azure.key -v -C
ansible-playbook ./sandbox-01_2.yaml -i "${public_ip}," -e @variables.yaml -u ${admin_user} --private-key ~/.ssh/azure.key -v -C 
ansible-playbook ./sandbox-01_3.yaml -i "${public_ip}," -e @variables.yaml -u ${admin_user} --private-key ~/.ssh/azure.key -v -C 

ansible-playbook ./sandbox-01_1.yaml -i "${public_ip},"                    -u ${admin_user} --private-key ~/.ssh/azure.key -vv
ansible-playbook ./sandbox-01_2.yaml -i "${public_ip}," -e @variables.yaml -u ${admin_user} --private-key ~/.ssh/azure.key -vv 
ansible-playbook ./sandbox-01_3.yaml -i "${public_ip}," -e @variables.yaml -u ${admin_user} --private-key ~/.ssh/azure.key -vv 

rm -f *.retry

cd ..   # mackerel-practice
```


## Setting Contents, Resources
### 00.ssh/config
``` 
# sandbox-01
Host sandbox-01
  User ${Set vm_admin_user ID}
  Hostname ${Set sandbox-01 public ip}
  IdentityFile ${Set Yours}
```

### 01.Terraform
#### terraform.tfvars
``` 
subscription_id = "${Set Yours}"
client_id       = "${Set Yours}"
client_secret   = "${Set Yours}"
tenant_id       = "${Set Yours}"

myhome_gip = "${Set Yours}"

vm_admin_user = "${Set Yours}"
vm_admin_ssh_public_key = "ssh-rsa... ${Set Yours}"
```

### 02.Ansible
### inventory (Optional)
```
[localhost]
127.0.0.1 ansible_connection=local

[sandbox]
sandbox-01   ansible_host=${Set public ip}

[sandbox:vars]
ansible_ssh_user=${Set Yours}
ansible_ssh_private_key_file=${Set Yours}
ansible_become=yes
ansible_become_user=root
ansible_become_method=enable
```

### variables.yaml
``` 
mackerel_agent_apikey: "${Set Yours}"
```


# Footnote
[^1]: バージョン切り替え時は対象をたとえば tfenv install 0.12.21 でインストールして tfenv use 0.12.21 で切り替える。現在使用中のバージョンは .terraform-version に記述されている。  
[^2]: デフォルトの有効期限は１年であることに要注意。また、Azureインテグレーションを利用する場合、 Role は Reader が妥当。 see [Azureインテグレーション - Mackerel ヘルプ](https://mackerel.io/ja/docs/entry/integrations/azure#Azure-CLI-20%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E9%80%A3%E6%90%BA%E6%96%B9%E6%B3%95)
