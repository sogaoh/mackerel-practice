resource "aws_vpc" "practice-vpc" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "practice_vpc"
  }
}

resource "aws_subnet" "bastion-subnet" {
  vpc_id = aws_vpc.practice-vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = var.aws_zone_d

  tags = {
    Name = "bastion-subnet_practice"
  }
}

/*
resource "aws_subnet" "public-subnet-d" {
  vpc_id = aws_vpc.practice-vpc.id
  cidr_block = "10.1.11.0/24"
  availability_zone = var.aws_zone_d

  tags = {
    Name = "public-subnet-d_practice"
  }
}
*/

resource "aws_subnet" "private-subnet-d" {
  vpc_id = aws_vpc.practice-vpc.id
  cidr_block = "10.1.21.0/24"
  availability_zone = var.aws_zone_d

  tags = {
    Name = "private-subnet-d_practice"
  }
}

resource "aws_subnet" "db-subnet-d" {
  vpc_id = aws_vpc.practice-vpc.id
  cidr_block = "10.1.31.0/24"
  availability_zone = var.aws_zone_d

  tags = {
    Name = "db-subnet-d_practice"
  }
}

resource "aws_subnet" "db-subnet-c" {
  vpc_id = aws_vpc.practice-vpc.id
  cidr_block = "10.1.32.0/24"
  availability_zone = var.aws_zone_c

  tags = {
    Name = "db-subnet-c_practice"
  }
}