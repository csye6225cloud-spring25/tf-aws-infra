# Dev Configuration (uncomment when working on Dev)
# data "aws_route53_zone" "dev_zone" {
#   zone_id = "Z0624390ZXDW2D39OXCG"
# }

# resource "aws_route53_record" "dev_alb" {
#   zone_id = data.aws_route53_zone.dev_zone.zone_id
#   name    = "dev.onerahul.me"
#   type    = "A"
#   alias {
#     name                   = aws_lb.app_alb.dns_name # References the Dev ALB
#     zone_id                = aws_lb.app_alb.zone_id  # References the Dev ALB zone ID
#     evaluate_target_health = true
#   }
# }

# Demo Configuration (uncomment when working on Demo)
data "aws_route53_zone" "demo_zone" {
  zone_id = "Z06229003B7BF36WA89MH" # Replace with your Demo hosted zone ID
}

resource "aws_route53_record" "demo_alb" {
  zone_id = data.aws_route53_zone.demo_zone.zone_id
  name    = "demo.onerahul.me"
  type    = "A"
  alias {
    name                   = aws_lb.app_alb.dns_name # References the Demo ALB
    zone_id                = aws_lb.app_alb.zone_id  # References the Demo ALB zone ID
    evaluate_target_health = true
  }
}