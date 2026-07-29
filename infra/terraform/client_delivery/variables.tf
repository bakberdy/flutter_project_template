variable "github_owner" {
  description = "GitHub organization or user that owns the repository."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name created from this template."
  type        = string
}

variable "production_reviewer_user_ids" {
  description = "GitHub numeric user IDs allowed to approve client-production."
  type        = list(number)
  default     = []
}
