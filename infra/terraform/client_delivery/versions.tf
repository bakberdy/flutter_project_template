terraform {
  required_version = ">= 1.12.0"

  backend "s3" {}

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
