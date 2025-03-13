resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true   # Prevents public ACLs
  block_public_policy     = true   # Prevents bucket-wide public policies
  ignore_public_acls      = true   # Ignores any public ACLs applied
  restrict_public_buckets = true   # Blocks public access completely
}


# 🔹 CloudFront Origin Access Identity (OAI)
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for CloudFront to access S3"
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.example.id

  policy = templatefile("${path.module}/s3_policy.json.tpl", {
    oai_arn     = var.oai_arn   # ✅ Use the correct variable
    bucket_name = aws_s3_bucket.example.bucket  # ✅ Fix the reference
  })
}


# 🔹 Upload the Index.html File
resource "aws_s3_object" "index" {
  bucket      = aws_s3_bucket.example.id
  key         = "index.html"
  source      = "${path.module}/index.html"
  content_type = "text/html"
}

