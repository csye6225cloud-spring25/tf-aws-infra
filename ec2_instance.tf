resource "aws_instance" "app_instance" {
  ami                         = var.custom_ami # AMI built by Packer
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnets["public_subnet_1"].id
  vpc_security_group_ids      = [aws_security_group.application_sg.id]
  associate_public_ip_address = true
  disable_api_termination     = false # Not protected against accidental termination

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "app_instance"
  }
}
