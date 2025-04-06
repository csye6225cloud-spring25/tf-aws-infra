# kms.tf

# KMS Key for EC2 (EBS volumes)
resource "aws_kms_key" "ec2_key" {
  description             = "KMS key for EC2 EBS volumes"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

# KMS Key for RDS
resource "aws_kms_key" "rds_key" {
  description             = "KMS key for RDS instance"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

# KMS Key for S3 Buckets
resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 buckets"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

# KMS Key for Secrets Manager (Database Password and Email Credentials)
resource "aws_kms_key" "secrets_key" {
  description             = "KMS key for Secrets Manager"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}