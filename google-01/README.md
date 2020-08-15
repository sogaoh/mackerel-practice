# mackerel-practice/google-01

GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する の関連コード

refs 
- Pubs/Mackerel Ambassador (sogaoh) blogs/
    - [GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する (1)](https://esa-pages.io/p/sharing/6641/posts/976/ebc3295116a84b02c966.html)
    - GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する (2)


## Pre-Requirements
- Local 
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 0.12.29 [^1]
    - GCP Cloud SDK setup
        - refs https://cloud.google.com/sdk/docs/quickstarts?hl=ja
    - install anyenv (or rbenv)
        - [macOS] brew install anyenv
            - anyenv install rbenv
            - rbenv install 2.4.0
    - install direnv
        - [macOS] brew install direnv
    - install heroku CLI
        - refs https://devcenter.heroku.com/articles/heroku-cli

- GCP 
    - Project
    - Service account (for terraform operation)
        - Credential initialized
    - GCS bucket (Optional)

- Google Analytics 
    - Account sign up
        - (Able to grant user)
        - Property
            - View 
                - confirm ID 

- Heroku
    - Account sign up

- Sign up https://mackerel.io/
    - confirm API key 


## Execution procedure

### 01.terraform_iam
```
cd ${your_appropriate_directory_1}
git clone https://github.com/sogaoh/mackerel-practice.git

cd mackerel-practice/google-01/01_terraform_iam
(vi terraform.tfvars)

terraform init
terraform plan
terraform apply

cd ..   # mackerel-practice/google-01
```


### 02.heroku_app_debug
```
cd ${your_appropriate_directory_2}
git clone https://github.com/ant-in-giant/currentvisitor2mackerel

cd currentvisitor2mackerel
(vi .envrc)

(direnv allow)

rbenv exec gem install bundle
bundle install

bundle exec ruby app.rb -p 9876   # 9876 は適宜変えてください
```


### 03.heroku_deploy
1. Push your `Deploy` button 
    - example: https://github.com/ant-in-giant/currentvisitor2mackerel
2. Set Parameters
    - App name : ${Set Yours}
    - Choose a regin : United States (or Europe)
    - Config Vars
        - GOOGLE_API_KEY        : ${Set Yours}
        - MACKEREL_API_KEY      : ${Set Yours}
        - MACKEREL_SERVICE_NAME : ${Set Yours}
        - PROFILE_ID            : ${Set Yours} (Google Analytics View ID)  
        - SERVICE_ACCOUNT_EMAIL : ${Set Yours}
        - WEBSITE_NAME          : ${Set Yours} ex) gitpitch
3. Push `Deploy app` button... 


### 04.terraform_jobs
```
(mackerel-practice/google-01)

cd 03_terraform_jobs
(vi terraform.tfvars)

terraform init
terraform plan
terraform apply

cd ..   # mackerel-practice/google-01
```


## Setting Contents

### 01.terraform_iam
#### terraform.tfvars
``` 
project = "${Set Yours}"
region  = "${Set Yours}"
credentials = "{ \"type\": \"service_account\", \"project_id\":...${Set Yours}...iam.gserviceaccount.com\" }"
```

### 02.heroku_app_debug
#### .envrc
```
export SERVICE_ACCOUNT_EMAIL=${service_account}@${your_gcp_project}.iam.gserviceaccount.com
export PROFILE_ID=${your_analytics_view_id}
export GOOGLE_API_KEY="-----BEGIN PRIVATE KEY----- {{ \nを含む private_key }} -----END PRIVATE KEY-----"
export WEBSITE_NAME=${Set Yours}
export MACKEREL_API_KEY=${your_mackerel_api_key}
export MACKEREL_SERVICE_NAME=${Set Yours}
```

### 04.terraform_jobs
#### terraform.tfvars
``` 
project = "${Set Yours}"
region  = "${Set Yours}"
credentials = "{ \"type\": \"service_account\", \"project_id\":...${Set Yours}...iam.gserviceaccount.com\" }"

myblog_name = "${Set Yours}"
myblog-visitor-count_app_url = "${Set Your Heroku App URL}"
```


# Footnote
[^1]: バージョン切り替え時は対象をたとえば tfenv install 0.12.29 でインストールして tfenv use 0.12.29 で切り替える。現在使用中のバージョンは .terraform-version に記述されている。  

