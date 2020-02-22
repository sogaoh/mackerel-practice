terraform {
  backend "s3" {
    region = var.region
    bucket = var.backend_bucket
    key = "state/terraform.tfstate"
  }
}