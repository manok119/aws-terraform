resource "aws_db_instance" "iac-rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "iac-db"
  username             = "mysql"
  password             = "lqsym"
  db_name              = "sample"
  db_subnet_group_name = data.aws_db_subnet_group.iac-db-subnect-group
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone = "ap-northeast-2c"
}

resource "aws_db_subnet_group" "iac-db-subnect-group" {
  name       = "iac-db-subnect-group"
  subnet_ids = [aws_subnet.iac-private-subnet-2.id]

  tags = {
    Name = "iac-db-subnect-group"
  }
}