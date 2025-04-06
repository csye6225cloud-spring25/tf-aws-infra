# launchtemplate.tf
resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-lt-"
  image_id      = "ami-0ee902fffb2e0f75d"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.application_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 25
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_key.arn
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    db_username    = var.db_username
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
}