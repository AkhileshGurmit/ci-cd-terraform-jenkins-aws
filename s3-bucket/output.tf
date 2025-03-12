# Output the S3 Bucket Name
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.example.id
}

# Output the S3 Bucket Regional Domain Name (Used for CloudFront Origin)
output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket (Used in CloudFront)"
  value       = aws_s3_bucket.example.bucket_regional_domain_name
}


# Output the S3 Bucket ID (Fixing Missing Output)
output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.example.id
}
