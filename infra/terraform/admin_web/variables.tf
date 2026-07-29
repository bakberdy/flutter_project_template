variable "aws_region" {
  description = "AWS region for Admin Web buckets."
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Admin-only AWS resource name prefix."
  type        = string
  default     = "template-admin-web"
}

variable "github_owner" {
  type    = string
  default = "bakberdy"
}

variable "github_repository" {
  type    = string
  default = "flutter_project_template"
}

variable "github_oidc_provider_arn" {
  description = "Existing GitHub Actions OIDC provider ARN, or null to create it."
  type        = string
  default     = null
}

variable "manage_github_configuration" {
  description = "Manage Admin GitHub environments, variables and ruleset."
  type        = bool
  default     = true
}

variable "production_reviewer_user_ids" {
  description = "GitHub numeric user IDs allowed to approve admin-production."
  type        = list(number)
  default     = []
}

variable "environment_config" {
  description = "Non-secret Admin Flutter compile-time configuration."
  type = map(object({
    api_url                 = string
    enable_logging          = bool
    enable_analytics        = bool
    enable_crashlytics      = bool
    connect_timeout_seconds = number
    receive_timeout_seconds = number
    send_timeout_seconds    = number
  }))

  validation {
    condition     = toset(keys(var.environment_config)) == toset(["development", "production"])
    error_message = "environment_config must contain exactly development and production."
  }
}
