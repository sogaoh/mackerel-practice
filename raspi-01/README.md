# mackerel-practice/raspi-01 

RaspberryPi起点で自宅インターネット回線モニタリング作戦 の環境構築コード

refs 
- Pubs/Mackerel Ambassador (sogaoh) blogs/
    - [RaspberryPiからSpeedtestCLIの結果をMackerelサービスメトリックに投稿する (1)](https://esa-pages.io/p/sharing/6641/posts/798/a519fa8de990076c0ed8.html) 
    - [RaspberryPiからSpeedtestCLIの結果をMackerelサービスメトリックに投稿する (2)](https://esa-pages.io/p/sharing/6641/posts/799/7749ccbd8d0d242b410b.html)
    

## Pre-Requirements
- RaspberryPi 
    - Purchase
    - Assemble
    - Initial setup
        - refs [RaspberryPi起点で自宅インターネット回線のモニタリング作戦 (1/4 : RaspberryPi4 セットアップ) - Zenn](https://zenn.dev/sogaoh/articles/2020_04_10_20_23-from-qrunch)
    - SSH connect configure (for running `ansible-playbook`)

- Local 
    - install Ansible
        - [macOS] brew install ansible

- Sign up https://mackerel.io/
    - confirm API key 


## Execution procedure
```
cd ${your_appropriate_directory}
git clone https://github.com/sogaoh/mackerel-practice.git

cd mackerel-practice/raspi-01
```

```

cd 02_ansible/roles
#ansible-galaxy install mackerelio.mackerel-agent
#mv ${/path/to/.ansible}/roles/* ./ 
cd ..    # 02_ansible

(vi inventry)
(vi variables.yaml)

ansible-playbook ./raspi-01.yaml -i "[target host IP, etc...],"  -e @variables.yaml -v -C

ansible-playbook ./raspi-01.yaml -i "[target host IP, etc...],"  -e @variables.yaml -vv

rm -f *.retry

cd ../..   # mackerel-practice
```


## Setting Contents, Resources

## variables.yaml
``` 
mackerel_agent_apikey: "${Set Yours}"
service_to_post: "${Set Service}"
```

## inventory (if necessary)
```
[localhost]
127.0.0.1 ansible_connection=local

[raspi]
raspi-01  ansible_host=192.168.0.34

[raspi:vars]
#ansible_port=${Set if necessary}
ansible_ssh_user=pi     # RaspberryPi default
ansible_ssh_private_key_file=${Set Yours}
ansible_become=yes
ansible_become_user=root
ansible_become_method=enable
```

# Appendix
## Sub modules
- [mackerel-agent-raspi](02_ansible/roles/mackerel-agent-raspi)
- [mackerel-plugins-raspi](02_ansible/roles/mackerel-plugins-raspi)
- [speedtest_net-cli-raspi](02_ansible/roles/speedtest_net-cli-raspi)
- [sardine_service-raspi](02_ansible/roles/sardine_service-raspi)


<!-- 
# Footnote
-->
