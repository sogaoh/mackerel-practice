resource "aws_key_pair" "ssh-key_practice" {
  key_name = var.key_name
  public_key = file(var.public_key_path)
}


resource "aws_instance" "docker-01" {
  ami = "ami-0cd744adeca97abb1" //Ubuntu Server 18.04 LTS (HVM), SSD Volume Type (64 ビット x86)
  instance_type = var.instance_type_docker
  subnet_id = aws_subnet.private-subnet-d.id
  associate_public_ip_address = true  //temporary
  private_ip = "10.1.21.10"
  vpc_security_group_ids = [
    aws_vpc.practice-vpc.default_security_group_id,
    aws_security_group.private-sg.id,
    aws_security_group.es-sg.id,
  ]
  key_name = aws_key_pair.ssh-key_practice.id

  tags = {
    Name = "docker-01_practice"
  }
}