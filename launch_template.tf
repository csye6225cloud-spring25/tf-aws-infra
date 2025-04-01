# launch_template.tf (formerly ec2.tf)
resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-lt-"
  image_id      = "ami-0ef8bed579ec84474"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.application_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/sda1" # Maps to root_block_device
    ebs {
      volume_size           = 25
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    db_username    = var.db_username
    db_password    = var.db_password
    rds_endpoint   = aws_db_instance.database.endpoint
    db_name        = var.db_name
    aws_region     = var.aws_region
    s3_bucket_name = aws_s3_bucket.private_bucket.bucket
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app_instance"
    }
  }

  # Note: No subnet_id or associate_public_ip_address here; handled by ASG
}