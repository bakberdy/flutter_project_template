locals {
  environments = {
    development = {
      domain             = "dev.admin.bakberdi.dev"
      github_environment = "admin-development"
    }
    production = {
      domain             = "admin.bakberdi.dev"
      github_environment = "admin-production"
    }
  }

  common_tags = {
    Application = "admin-app"
    Component   = "admin-web"
    ManagedBy   = "terraform"
    Repository  = "${var.github_owner}/${var.github_repository}"
  }

  oidc_provider_arn = var.github_oidc_provider_arn != null ? var.github_oidc_provider_arn : aws_iam_openid_connect_provider.github[0].arn

  repository_variables = merge(
    {
      ADMIN_AWS_REGION = var.aws_region
    },
    merge([
      for environment, config in var.environment_config : {
        "ADMIN_${upper(environment)}_API_URL"                 = config.api_url
        "ADMIN_${upper(environment)}_ENVIRONMENT"             = environment
        "ADMIN_${upper(environment)}_ENABLE_LOGGING"          = tostring(config.enable_logging)
        "ADMIN_${upper(environment)}_ENABLE_ANALYTICS"        = tostring(config.enable_analytics)
        "ADMIN_${upper(environment)}_ENABLE_CRASHLYTICS"      = tostring(config.enable_crashlytics)
        "ADMIN_${upper(environment)}_CONNECT_TIMEOUT_SECONDS" = tostring(config.connect_timeout_seconds)
        "ADMIN_${upper(environment)}_RECEIVE_TIMEOUT_SECONDS" = tostring(config.receive_timeout_seconds)
        "ADMIN_${upper(environment)}_SEND_TIMEOUT_SECONDS"    = tostring(config.send_timeout_seconds)
        "ADMIN_${upper(environment)}_WEB_BUCKET"              = aws_s3_bucket.admin_web[environment].bucket
        "ADMIN_${upper(environment)}_PUBLISH_ROLE_ARN"        = aws_iam_role.publisher.arn
      }
    ]...)
  )

  environment_variables = merge([
    for environment, values in local.environments : {
      for name, value in {
        ADMIN_AWS_REGION                 = var.aws_region
        ADMIN_KVS_REGION                 = "us-east-1"
        ADMIN_WEB_BUCKET                 = aws_s3_bucket.admin_web[environment].bucket
        ADMIN_CLOUDFRONT_DISTRIBUTION_ID = aws_cloudfront_distribution.admin_web[environment].id
        ADMIN_KVS_ARN                    = aws_cloudfront_key_value_store.active_release[environment].arn
        ADMIN_PUBLIC_URL                 = "https://${values.domain}"
        ADMIN_DEPLOY_ROLE_ARN            = aws_iam_role.deployer[environment].arn
        } : "${environment}:${name}" => {
        environment = environment
        name        = name
        value       = value
      }
    }
  ]...)
}
