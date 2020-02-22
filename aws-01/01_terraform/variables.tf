variable "region" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "backend_bucket" {}

variable "aws_zone_d" {
  default = "ap-northeast-1d"
}

variable "aws_zone_c" {
  default = "ap-northeast-1c"
}

variable "myhome_gip" {}

variable "key_name" {
  description = "the name of aws key pair"
}

variable "public_key_path" {
  description = "path to the ssh public key"
}


variable "instance_type_bastion" {
  default = "t2.micro"
}

variable "instance_type_docker" {
  default = "t2.medium"
}

variable "instance_type_rds" {
  default = "db.t2.micro"
}

variable "world_db_user" {}
variable "world_db_password" {}


variable "elasticsearch_version" {
  default = "7.1"
}

variable "instance_type_es" {
  default = "t2.small.elasticsearch"
}

variable "instance_count_es" {
  default = 1
}

variable "ebs_volume_type_es" {
  default = "gp2"
}

variable "ebs_volume_size_es" {
  default = 10
}

variable "mackerel_aws_integration_account_id" {}
variable "mackerel_aws_integration_external_id" {}