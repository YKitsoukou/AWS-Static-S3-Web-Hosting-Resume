resource "aws_s3_bucket" "bucket1" {
    bucket = "name" # must follow s3 requirement. 
tags = {
  name= "Resume-challenge"
}
}

resource "aws_s3_bucket_public_access_block" "bucket1" {
  bucket = "name" # must follow s3 requirement.

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index" {
  bucket = "name" # must follow s3 requirement.
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "css" {
  bucket = "name" # must follow s3 requirement.
  key    = "styles.css"
  source = "styles.css"
  content_type = "text/html"
}



resource "aws_s3_bucket_website_configuration" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket1.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket1.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.my_origin_access_identity.iam_arn]
    }
  }
}