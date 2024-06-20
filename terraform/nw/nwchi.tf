provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

# Cert
resource "aws_acm_certificate" "nwchi-jjxu-dev" {
  domain_name = "nwchi.jjxu.dev"
  subject_alternative_names = [ "nw.jjxu.dev" ]
  validation_method = "DNS"
  key_algorithm     = "RSA_2048"

  provider = aws.us-east-1
}

resource "aws_route53_record" "jjxu-dev-validation" {
  for_each = {
    for dvo in aws_acm_certificate.nwchi-jjxu-dev.domain_validation_options : dvo.domain_name => {
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
  zone_id         = var.route53_zone_id

  provider = aws.us-east-1
}

# S3 Bucket Redirect
resource "aws_s3_bucket" "nwchi-jjxu-dev-bucket" {
  bucket = "nwchi.jjxu.dev"
}

resource "aws_s3_bucket_website_configuration" "nwchi-jjxu-dev-bucket" {
  bucket = aws_s3_bucket.nwchi-jjxu-dev-bucket.id

   index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  routing_rule {
    redirect {
      host_name = "docs.google.com"
      replace_key_with = "/forms/d/e/1FAIpQLSd99uFVTX_x0mmJ5HhPZqyWhK6I5LSPE06jsxHbmaFv1dA_rg/viewform?usp=sf_link"
      protocol = "https"
    }
  }
}


resource "aws_s3_bucket_ownership_controls" "nwchi-jjxu-dev-bucket" {
  bucket = aws_s3_bucket.nwchi-jjxu-dev-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "nwchi-jjxu-dev-bucket" {
  bucket = aws_s3_bucket.nwchi-jjxu-dev-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "nwchi-jjxu-dev-bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.nwchi-jjxu-dev-bucket,
    aws_s3_bucket_public_access_block.nwchi-jjxu-dev-bucket,
  ]

  bucket = aws_s3_bucket.nwchi-jjxu-dev-bucket.id
  acl    = "public-read"
}

data "aws_iam_policy_document" "nwchi-jjxu-dev-bucket_public-read" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::nwchi.jjxu.dev/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "nwchi-jjxu-dev-bucket_public-read" {
  bucket = aws_s3_bucket.nwchi-jjxu-dev-bucket.id
  policy = data.aws_iam_policy_document.nwchi-jjxu-dev-bucket_public-read.json
}

# Cloudfront
resource "aws_cloudfront_distribution" "nwchi-jjxu-dev-prod-distribution" {
  origin {
    domain_name = aws_s3_bucket.nwchi-jjxu-dev-bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.nwchi-jjxu-dev-bucket.id
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = aws_s3_bucket.nwchi-jjxu-dev-bucket.id
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching-optimized.id
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.nwchi-jjxu-dev.arn
    ssl_support_method  = "sni-only"
  }

  aliases             = ["nwchi.jjxu.dev"]
  default_root_object = "index.html"
  enabled             = true
}

data "aws_cloudfront_cache_policy" "caching-optimized" {
  name = "Managed-CachingOptimized"
}

# Route53
resource "aws_route53_record" "nwchi-jjxu-dev" {
  zone_id = var.route53_zone_id
  type    = "A"
  name    = "nwchi.jjxu.dev"

  alias {
    name                   = aws_cloudfront_distribution.nwchi-jjxu-dev-prod-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.nwchi-jjxu-dev-prod-distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
