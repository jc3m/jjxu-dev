terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider aws {
  region = "us-east-2"
}

resource "aws_s3_bucket" "jjxu-dev-bucket" {
  bucket = "jjxu-dev-prod"

  tags = {
    Name        = "jjxu.dev"
    Environment = "production"
  }
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.jjxu-dev-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
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
      "arn:aws:s3:::jjxu-dev-prod/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "jjxu-dev-bucket_public-read" {
  bucket = aws_s3_bucket.jjxu-dev-bucket.id
  policy = data.aws_iam_policy_document.jjxu-dev-bucket_public-read.json
}
