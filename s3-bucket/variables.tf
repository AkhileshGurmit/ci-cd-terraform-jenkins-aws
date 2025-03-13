variable "bucket_name"{
    description="Name of the s3 bucket"
    type=string
    default="my-terraform-s3-bucket-crazy-india-12345"
}

variable "oai_arn" {
  description = "The ARN of the CloudFront Origin Access Identity"
  type        = string
}
