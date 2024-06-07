resource "aws_route53_record" "frontend" {
  zone_id = var.zone_id
  name    = "${var.subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    # prevent_destroy = true
    ignore_changes  = [name, zone_id, type]
  }
}
