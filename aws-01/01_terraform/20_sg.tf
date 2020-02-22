resource "aws_security_group" "bastion-sg" {
  name = "bastion-sg"
  vpc_id = aws_vpc.practice-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.1.0.0/16", "${var.myhome_gip}/32"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  tags = {
    Name = "bastion-sg_practice"
  }
}


resource "aws_security_group" "public-sg" {
  name = "public-sg"
  vpc_id = aws_vpc.practice-vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  tags = {
    Name = "public-sg_practice"
  }
}


resource "aws_security_group" "private-sg" {
  name = "private-sg"
  vpc_id = aws_vpc.practice-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.1.0.0/16", "${var.myhome_gip}/32"]   //temporary
    //cidr_blocks = ["10.1.0.0/16"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  tags = {
    Name = "private-sg_practice"
  }
}


resource "aws_security_group" "es-sg" {
  name = "es-sg"
  vpc_id = aws_vpc.practice-vpc.id

  ingress {
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    cidr_blocks = ["10.1.0.0/16", "${var.myhome_gip}/32"]
  }

  ingress {
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
    cidr_blocks = ["10.1.0.0/16", "${var.myhome_gip}/32"]
  }

  tags = {
    Name = "es-sg_practice"
  }
}


resource "aws_security_group" "db-sg" {
  name = "db-sg"
  vpc_id = aws_vpc.practice-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "10.1.21.0/24",
      "10.1.31.0/24","10.1.32.0/24"
    ]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  /* MySQL */
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      "10.1.21.0/24",
      "10.1.31.0/24","10.1.32.0/24"
    ]
  }

  /* PostgreSQL */
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "10.1.21.0/24",
      "10.1.31.0/24","10.1.32.0/24"
    ]
  }

  tags = {
    Name = "db-sg_practice"
  }
}
