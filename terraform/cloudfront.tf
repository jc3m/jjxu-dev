resource "aws_cloudfront_distribution" "jjxu-dev-prod-distribution" {
  origin {
    domain_name = aws_s3_bucket.jjxu-dev-bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.jjxu-dev-bucket.id
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
    target_origin_id       = aws_s3_bucket.jjxu-dev-bucket.id
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching-optimized.id
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.jjxu-dev.arn
    ssl_support_method  = "sni-only"
  }

  aliases             = ["www.jjxu.dev"]
  default_root_object = "index.html"
  enabled             = true
}

resource "aws_cloudfront_distribution" "jjxu-dev-prod-distribution-root" {
  origin {
    domain_name = aws_s3_bucket.jjxu-dev-bucket-root.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.jjxu-dev-bucket-root.id
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
    target_origin_id       = aws_s3_bucket.jjxu-dev-bucket-root.id
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching-disabled.id
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.jjxu-dev.arn
    ssl_support_method  = "sni-only"
  }

  aliases = ["jjxu.dev"]
  enabled = true
}

data "aws_cloudfront_cache_policy" "caching-optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "caching-disabled" {
  name = "Managed-CachingDisabled"
}
