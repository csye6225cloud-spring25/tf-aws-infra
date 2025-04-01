# Dev AWS Account Terraform directory

# Reference the existing hosted zone for dev.onerahul.me
data "aws_route53_zone" "dev_zone" {
  zone_id = "Z0624390ZXDW2D39OXCG"  
}

# Create an A record alias pointing to the ALB
resource "aws_route53_record" "dev_alb" {
  zone_id = data.aws_route53_zone.dev_zone.zone_id
  name    = "dev.onerahul.me"
  type    = "A"
  alias {
    name                   = aws_lb.app_alb.dns_name   # Reference to your ALB’s DNS name
    zone_id                = aws_lb.app_alb.zone_id    # Reference to your ALB’s zone ID
    evaluate_target_health = true
  }
}