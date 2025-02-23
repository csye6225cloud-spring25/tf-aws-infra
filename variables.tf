variable "aws_region" {
  type        = string
  description = "AWS region for the deployment"
}

variable "vpc_name" {
  type        = string
  default     = "demo_vpc"
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "private_subnets" {
  type        = map(string)
  description = "Map of private subnet names to their CIDR blocks"
}

variable "public_subnets" {
  type        = map(string)
  description = "Map of public subnet names to their CIDR blocks"
}


variable "custom_ami" {
  description = "Custom AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "app_port" {
  description = "Application port for the web app"
  type        = number
  default     = 3000
}