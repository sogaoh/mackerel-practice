terraform {
  backend "s3" {
    region = "ap-northeast-1"
    bucket = "practice-tf-store"
    key = "state/terraform.tfstate"
  }
}