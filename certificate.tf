resource "aws_acm_certificate" "app_cert" {
  count             = var.environment == "dev" ? 1 : 0
  domain_name       = "dev.onerahul.me"
  validation_method = "DNS"

  tags = {
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "app_cert" {
  count                   = var.environment == "dev" ? 1 : 0
  certificate_arn         = aws_acm_certificate.app_cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

data "aws_acm_certificate" "demo_cert" {
  count    = var.environment == "demo" ? 1 : 0
  domain   = "demo.onerahul.me"
  statuses = ["ISSUED"]
}