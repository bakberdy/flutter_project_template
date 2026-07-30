provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = local.common_tags
  }
}

provider "github" {
  owner = var.github_owner
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "github_user" "owner" {
  username = var.github_owner
}

data "github_repository" "current" {
  full_name = "${var.github_owner}/${var.github_repository}"
}
