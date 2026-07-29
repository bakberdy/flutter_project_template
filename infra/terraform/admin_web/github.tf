resource "github_repository_environment" "admin" {
  for_each = var.manage_github_configuration ? local.environments : {}

  repository  = var.github_repository
  environment = each.value.github_environment

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

resource "github_repository_environment_deployment_policy" "admin_tags" {
  for_each = var.manage_github_configuration ? local.environments : {}

  repository     = var.github_repository
  environment    = github_repository_environment.admin[each.key].environment
  branch_pattern = "admin-v*"
}

resource "github_actions_variable" "repository" {
  for_each = var.manage_github_configuration ? local.repository_variables : {}

  repository    = var.github_repository
  variable_name = each.key
  value         = each.value
}

resource "github_actions_environment_variable" "admin" {
  for_each = var.manage_github_configuration ? local.environment_variables : {}

  repository    = var.github_repository
  environment   = github_repository_environment.admin[each.value.environment].environment
  variable_name = each.value.name
  value         = each.value.value
}

resource "github_repository_ruleset" "admin_delivery" {
  count = var.manage_github_configuration ? 1 : 0

  name        = "admin-delivery"
  repository  = var.github_repository
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context = "Admin Delivery Gate"
      }
    }
  }
}
