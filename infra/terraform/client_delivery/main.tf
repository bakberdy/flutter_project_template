locals {
  environments = {
    development = "client-development"
    production  = "client-production"
  }
}

resource "github_repository_environment" "client" {
  for_each = local.environments

  repository  = var.github_repository
  environment = each.value

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }

  dynamic "reviewers" {
    for_each = each.key == "production" && length(var.production_reviewer_user_ids) > 0 ? [1] : []
    content {
      users = var.production_reviewer_user_ids
    }
  }
}

resource "github_repository_environment_deployment_policy" "client_tags" {
  for_each = local.environments

  repository     = var.github_repository
  environment    = github_repository_environment.client[each.key].environment
  branch_pattern = "client-${each.key}-v*"
}
