variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "state_bucket_name" {
  description = "Globally unique bucket name for Admin Web Terraform state."
  type        = string
  default     = null
}
