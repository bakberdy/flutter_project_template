output "admin_domains" {
  description = "Admin-only public domains."
  value       = { for environment, values in local.environments : environment => "https://${values.domain}" }
}

output "acm_validation_records" {
  description = "CNAME records that must be created manually in the external DNS provider before the full apply."
  value = {
    for environment, certificate in aws_acm_certificate.admin_web :
    environment => [
      for option in certificate.domain_validation_options : {
        name  = option.resource_record_name
        type  = option.resource_record_type
        value = option.resource_record_value
      }
    ]
  }
}

output "admin_dns_records" {
  description = "CNAME targets to create manually after CloudFront distributions exist."
  value = {
    for environment, distribution in aws_cloudfront_distribution.admin_web :
    environment => {
      name  = local.environments[environment].domain
      type  = "CNAME"
      value = distribution.domain_name
    }
  }
}

output "admin_web_buckets" {
  description = "Private immutable Admin Web artifact buckets."
  value       = { for environment, bucket in aws_s3_bucket.admin_web : environment => bucket.bucket }
}

output "admin_cloudfront_distributions" {
  value = {
    for environment, distribution in aws_cloudfront_distribution.admin_web :
    environment => {
      id          = distribution.id
      domain_name = distribution.domain_name
    }
  }
}

output "admin_publish_role_arn" {
  value = aws_iam_role.publisher.arn
}

output "admin_deploy_role_arns" {
  value = { for environment, role in aws_iam_role.deployer : environment => role.arn }
}

output "admin_kvs_arns" {
  value = { for environment, store in aws_cloudfront_key_value_store.active_release : environment => store.arn }
}
