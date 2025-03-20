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
  engine_version        = "17"          # Adjust based on AWS supported versions
  instance_class        = "db.t3.micro" # Cheapest tier
  allocated_storage     = 20            # Minimum storage
  max_allocated_storage = 100           # Allows auto-scaling up to 100GB

  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = aws_db_parameter_group.postgresql_parameters.name
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false # No public access
  multi_az               = false # No multi-AZ (single instance)
  skip_final_snapshot    = true

  tags = {
    Name = "webapp_rds_instance"
  }
}