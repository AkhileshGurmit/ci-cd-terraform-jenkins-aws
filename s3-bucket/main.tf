resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}

# 🔹 Restricting Direct Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 🔹 CloudFront Origin Access Identity (OAI)
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for CloudFront to access S3"
}

# 🔹 Setting Bucket Policy to Allow Only CloudFront OAI
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontAccess"
        Effect    = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.example.bucket}/*"
      }
    ]
  })
}

# 🔹 Upload the Index.html File
resource "aws_s3_object" "index" {
  bucket      = aws_s3_bucket.example.id
  key         = "index.html"
  source      = "${path.module}/index.html"
  content_type = "text/html"
}
