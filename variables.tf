variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  type        = string
  default     = "ami-085ad6ae776d8f09c"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-terraform-s3-bucket-crazy-india-12345"
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for CloudFront (if using a custom cert)"
  type        = string
  default     = ""  # Leave empty to use CloudFront default certificate
}
