output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_name  # ✅ Ensure "s3" module exists in main.tf
}

output "cloudfront_domain" {
  value = module.cloudfront.cloudfront_domain_name  # ✅ Use "cloudfront" not "cloudfront-cdn"
}

output "oai_arn" {
  value = module.cloudfront.oai_arn  # ✅ Ensure module.cloudfront outputs "oai_arn"
}
