resource "aws_db_subnet_group" "world-db-subnet-group" {
  name        = "world-db-subnet"
  subnet_ids  = [aws_subnet.db-subnet-d.id, aws_subnet.db-subnet-c.id]
}

resource "aws_db_parameter_group" "world-db-parameter-group" {
  name = "world-db-parameter-group"
  family = "mysql5.7"

  parameter {
    name = "time_zone"
    value = "Asia/Tokyo"
  }
}

resource "aws_db_instance" "world-db" {
  allocated_storage      = 20
  #max_allocated_storage = 50
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  db_subnet_group_name   = aws_db_subnet_group.world-db-subnet-group.name
  instance_class         = var.instance_type_rds
  identifier             = "test-world-db"
  name                   = "world"
  username               = var.world_db_user
  password               = var.world_db_password
  parameter_group_name   = aws_db_parameter_group.world-db-parameter-group.name
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  skip_final_snapshot       = true
  #final_snapshot_identifier = "world-db-final-snapshot"
}

output "rds_endpoint" {
  value = aws_db_instance.world-db.endpoint
}