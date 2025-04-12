output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "alb_dns_name" {
  value       = aws_lb.app_alb.dns_name
  description = "The DNS name of the Application Load Balancer"
}
output "asg_name" {
  value       = aws_autoscaling_group.app_asg.name
  description = "The name of the autoscaling group"
}

output "launch_template_id" {
  value       = aws_launch_template.app_lt.id
  description = "The ID of the launch template"
}