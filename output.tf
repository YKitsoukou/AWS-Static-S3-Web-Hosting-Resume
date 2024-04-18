output "websiteendpoint" {
    value = aws_s3_bucket.bucket1.website_endpoint
}

output "aws_cloudfront_distribution" {
    value = aws_cloudfront_distribution.s3_distribution.domain_name
  
}

