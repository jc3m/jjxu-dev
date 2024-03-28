resource "aws_s3_bucket" "jjxu-dev-bucket" {
  bucket        = "www.jjxu.dev"
  force_destroy = true

  tags = {
    Name        = "jjxu.dev"
    Environment = "production"
  }
}

resource "aws_s3_bucket_website_configuration" "jjxu-dev-bucket" {
  bucket = aws_s3_bucket.jjxu-dev-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "jjxu-dev-bucket" {
  bucket = aws_s3_bucket.jjxu-dev-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "jjxu-dev-bucket" {
  bucket = aws_s3_bucket.jjxu-dev-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "jjxu-dev-bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.jjxu-dev-bucket,
    aws_s3_bucket_public_access_block.jjxu-dev-bucket,
  ]

  bucket = aws_s3_bucket.jjxu-dev-bucket.id
  acl    = "public-read"
}

data "aws_iam_policy_document" "jjxu-dev-bucket_public-read" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::www.jjxu.dev/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "jjxu-dev-bucket_public-read" {
  bucket = aws_s3_bucket.jjxu-dev-bucket.id
  policy = data.aws_iam_policy_document.jjxu-dev-bucket_public-read.json
}

# Root bucket redirect to www
resource "aws_s3_bucket" "jjxu-dev-bucket-root" {
  bucket = "jjxu.dev"
}

resource "aws_s3_bucket_website_configuration" "jjxu-dev-bucket-root" {
  bucket = aws_s3_bucket.jjxu-dev-bucket-root.id

  redirect_all_requests_to {
    host_name = "www.jjxu.dev"
    protocol  = "https"
  }
}
