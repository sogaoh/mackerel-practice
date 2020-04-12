# speedtest_net-cli-raspi (install to RaspberryPi 4)
a Ansible Role

## What's this ?
- Raspberry Pi (4) に speedtest-cli (by speedtest.net) をインストールして  
  モニタリングを行うべく簡素にセットアップしたくて適当に作成した Ansible Role .

## Prerequirement
- 対象の Raspberry Pi 機種
    - SSH接続設定

## Usage
- Get and Set `speedtest_net-cli-raspi`
    - ex) 
        ```
        git clone https://github.com/sogaoh/mackerel-practice.git
        cd mackerel-practice/roles
        mv speedtest_net-cli-raspi ${your_properly_roles_directory}/
        cd ../..
        rm -rf mackerel-practice
        ```
- Prepare playbook (Sample is below:)
    ```
    - hosts: all
      become: yes

      roles:
        - speedtest_net-cli-raspi
    ```
- Run playbook
    - ex) `ansible-playbook ./my-raspi.yaml -i "[target host IP, etc...]," -vv -C`


## Assumed Result
```bash

# speedtest -f json-pretty
{
    "type": "result",
    "timestamp": "2020-04-11T09:06:53Z",
    "ping": {
        "jitter": 28.635999999999999,
        "latency": 29.620999999999999
    },
    "download": {
        "bandwidth": 23175090,
        "bytes": 284893272,
        "elapsed": 15004
    },
    "upload": {
        "bandwidth": 530434,
        "bytes": 7653352,
        "elapsed": 15001
    },
    "isp": "XXXXXXXXXXXX",
    "interface": {
        "internalIp": "192.168.0.34",
        "name": "eth0",
        "macAddr": "XX:XX:XX:XX:XX:XX",
        "isVpn": false,
        "externalIp": "XXX.XXX.XXX.XXX"
    },
    "server": {
        "country": "Japan",
    },
    "result": {
        "id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    }
}
```

(bandwidth:Mbps => bandwidth * 8 / 1000 / 1000)
