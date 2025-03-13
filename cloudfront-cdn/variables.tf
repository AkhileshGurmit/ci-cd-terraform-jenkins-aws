
variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for CloudFront (if not using the default certificate)"
  type        = string
  default     = ""  # Leave empty if you want to use the default CloudFront certificate
}

variable "s3_bucket_domain" {
  description = "The domain name of the S3 bucket"
  type        = string
}

variable "s3_origin_id" {
  description = "Origin ID for CloudFront"
  type        = string
}


