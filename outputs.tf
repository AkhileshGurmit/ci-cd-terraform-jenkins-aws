output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "cloudfront_domain" {
  value = module.cloudfront.cloudfront_domain_name
}