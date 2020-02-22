resource "aws_internet_gateway" "practice-igw" {
  vpc_id = aws_vpc.practice-vpc.id

  tags = {
    Name = "practice-igw"
  }
}


resource "aws_eip" "nat-gw-eip" {
  vpc = true
}
resource "aws_nat_gateway" "practice-nat-gw" {
  allocation_id = aws_eip.nat-gw-eip.id
  subnet_id = aws_subnet.bastion-subnet.id

  depends_on = [aws_internet_gateway.practice-igw]

  tags = {
    Name = "practice-nat-gw"
  }
}


resource "aws_route_table" "bastion-route" {
  vpc_id = aws_vpc.practice-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practice-igw.id
  }

  tags = {
    Name = "bastion-route_practice"
  }
}
resource "aws_route_table_association" "bastion-route-assoc" {
  subnet_id = aws_subnet.bastion-subnet.id
  route_table_id = aws_route_table.bastion-route.id
}


resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.practice-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practice-igw.id   //temporary
    //nat_gateway_id = aws_nat_gateway.practice-nat-gw.id
  }

  tags = {
    Name = "private-route_practice"
  }
}
resource "aws_route_table_association" "private-route-assoc" {
  subnet_id = aws_subnet.private-subnet-d.id
  route_table_id = aws_route_table.private-route.id
}

