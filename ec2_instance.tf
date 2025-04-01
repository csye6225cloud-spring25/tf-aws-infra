# ec2.tf
resource "aws_instance" "app_instance" {
  ami                         = "ami-0ef8bed579ec84474"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnets["public_subnet_1"].id
  vpc_security_group_ids      = [aws_security_group.application_sg.id]
  associate_public_ip_address = true
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name # Updated to combined profile

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  user_data = templatefile("${path.module}/user_data.sh", {
    db_username    = var.db_username
    db_password    = var.db_password
    rds_endpoint   = aws_db_instance.database.endpoint # RDS resource
    db_name        = var.db_name
    aws_region     = var.aws_region
    s3_bucket_name = aws_s3_bucket.private_bucket.bucket # S3 bucket resource
  })

  tags = {
    Name = "app_instance"
  }
}