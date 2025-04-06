# s3.tf
resource "aws_s3_bucket" "private_bucket" {
  bucket        = "csye6225-${uuid()}"
  force_destroy = true

  tags = {
    Name = "csye6225-private-bucket"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "private_bucket_encryption" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "private_bucket_lifecycle" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    id     = "transition-to-ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "private_bucket_block" {
  bucket = aws_s3_bucket.private_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "private_bucket_ownership" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}