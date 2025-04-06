# rds.tf
resource "aws_db_parameter_group" "postgresql_parameters" {
  name   = "custom-postgresql-params"
  family = "postgres17"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  tags = {
    Name = "custom_postgresql_parameter_group"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-private-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private_subnets : subnet.id]
  tags = {
    Name = "rds_private_subnet_group"
  }
}

resource "aws_db_instance" "database" {
  identifier            = "csye6225"
  engine                = "postgres"
  engine_version        = "17"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100

  db_name                = var.db_name
  username               = var.db_username
  password               = random_password.db_password.result # Updated to use generated password
  parameter_group_name   = aws_db_parameter_group.postgresql_parameters.name
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  multi_az               = false
  skip_final_snapshot    = true
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds_key.arn

  tags = {
    Name = "webapp_rds_instance"
  }
}