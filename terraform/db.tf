resource "aws_db_instance" "dreygosidb" {
  allocated_storage     = 10
  max_allocated_storage = 20

  db_subnet_group_name = aws_db_subnet_group.acad-dreygosi-subnet-group.id

  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "dreygosidb"
  identifier           = "dreygosidb"
  parameter_group_name = "default.mysql5.7"

  username = "root"
  password = "password"

  vpc_security_group_ids = [aws_security_group.acad-dreygosi-sg-db.id]

  tags = {
    Name    = "dreygosidb"
    Creator = var.creator
  }
}
