# lambda-cognito-metric

AWS Lambda Function for CloudWatch Metric of Cognito User Pool POST to Mackerel.

## How to use

### PreRequirements
- [Terraform](https://github.com/hashicorp/terraform) v1.0.7〜 
  - [terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws) v3.59.0〜
- [AWS CLI v2](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2.html) 2.2.37 〜
- Python 3.9
- [direnv](https://direnv.net/)
- **[lambroll](https://github.com/fujiwara/lambroll)** installed v0.11.8〜
  - [macOS] `brew install lambroll`

- AWS IAM User
  - Access Keys of `AdministratorAccess` User
  - `aws configure --profile XXXXX` done


### Create 
- uses [terraform-aws-modules/terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda) v2.17.0〜

```
cd create

(vi terraform.tfvars  # example below:)

terraform init
terraform plan
terraform apply
```


(terraform.tfvars example)

```terraform.tfvars
aws_access_key = "${ADMINISTRATOR_ACCESS_USER_ACCESS_KEY}"
aws_secret_key = "${ADMINISTRATOR_ACCESS_USER_SECRET_KEY}"
region = "ap-northeast-1"
profile = "XXXXXXX"

environment = "development"
service_name = "my-service"
```


### Update
``` 
cd lambroll

(vi .envrc  # example below:)
direnv allow

(edit function.json : if necessary)

make dry-deploy
make deploy
```


(.envrc example)

```.envrc
export AWS_ACCESS_KEY_ID="${ADMINISTRATOR_ACCESS_USER_ACCESS_KEY}"
export AWS_SECRET_ACCESS_KEY="${ADMINISTRATOR_ACCESS_USER_SECRET_KEY}"

export AWS_DEFAULT_REGION="ap-northeast-1"

export AWS_PROFILE="XXXXXXX"


export FUNCTION_INVOKE_ROLE="arn:aws:iam::${AWS_ACCOUNT_ID}:role/lambdaCognitoMetricInvokerRole"
```

