resource "aws_route53_zone" "jjxu-dev" {
  name = "jjxu.dev"
}

resource "aws_acm_certificate" "jjxu-dev" {
  domain_name       = "jjxu.dev"
  subject_alternative_names = ["www.jjxu.dev"]
  validation_method = "DNS"
  key_algorithm = "RSA_2048"

  provider = aws.us-east-1
}

resource "aws_route53_record" "jjxu-dev-validation" {
  for_each = {
    for dvo in aws_acm_certificate.jjxu-dev.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.jjxu-dev.zone_id

  provider = aws.us-east-1
}

resource "aws_route53_record" "jjxu-dev-www" {
  zone_id         = aws_route53_zone.jjxu-dev.zone_id
  type            = "A"
  name            = "www.jjxu.dev"

  alias {
    name                   = aws_cloudfront_distribution.jjxu-dev-prod-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.jjxu-dev-prod-distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate_validation" "jjxu-dev" {
  certificate_arn         = aws_acm_certificate.jjxu-dev.arn
  validation_record_fqdns = [for record in aws_route53_record.jjxu-dev-validation : record.fqdn]

  provider = aws.us-east-1
}
