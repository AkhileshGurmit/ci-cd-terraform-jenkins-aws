module "ec2" {
  source         = "./ec2-instance"
  instance_type  = var.instance_type
  ami_id         = var.ami_id
}

module "s3" {
  source      = "./s3-bucket"  # Make sure this folder exists in your directory
  bucket_name = var.bucket_name
  oai_arn     = module.cloudfront.oai_arn  # ✅ Pass OAI ARN correctly
}


module "cloudfront" {
  source               = "./cloudfront-cdn"  # Ensure folder name matches
  s3_bucket_domain     = module.s3.bucket_regional_domain_name
  s3_origin_id         = "S3-${var.bucket_name}"
  acm_certificate_arn  = var.acm_certificate_arn
}

