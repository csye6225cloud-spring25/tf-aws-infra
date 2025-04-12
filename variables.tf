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
  description = "The custom AMI ID built by Packer"
  type        = string
  default     = "ami-0000c40a8bb241438"
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "app_port" {
  description = "Port number for the application to listen on"
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Port number for the database connection"
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
  default     = "password"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "webapp"
}

variable "environment" {
  description = "The environment to deploy (dev or demo)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "demo"], var.environment)
    error_message = "Environment must be 'dev' or 'demo'."
  }
}

variable "hosted_zone_ids" {
  description = "Hosted zone IDs for dev and demo"
  type        = map(string)
  default = {
    dev  = "Z0624390ZXDW2D39OXCG"
    demo = "Z06229003B7BF36WA89MH"
  }
}

