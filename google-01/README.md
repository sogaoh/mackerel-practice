# mackerel-practice/google-01

GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する の関連コード

refs 
- Pubs/Mackerel Ambassador (sogaoh) blogs/
    - GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する (1)
    - GoogleAnalyticsで取得したアクティブユーザー数を定期的にMackerelサービスメトリックに投稿する (2)


## Pre-Requirements
- Local 
    - install tfenv
        - [macOS] brew install tfenv
    - install terraform
        - [macOS] tfenv install 0.12.29 [^1]
    - GCP Cloud SDK setup
        - refs https://cloud.google.com/sdk/docs/quickstarts?hl=ja
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



# Footnote
[^1]: バージョン切り替え時は対象をたとえば tfenv install 0.12.29 でインストールして tfenv use 0.12.29 で切り替える。現在使用中のバージョンは .terraform-version に記述されている。  

