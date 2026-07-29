check "admin_domain_contract" {
  assert {
    condition = (
      length(trimspace(local.environments.production.domain)) > 0 &&
      length(trimspace(local.environments.development.domain)) > 0 &&
      local.environments.production.domain != local.environments.development.domain
    )
    error_message = "Admin production and development domains must remain isolated and explicit."
  }
}

check "github_environment_contract" {
  assert {
    condition = (
      local.environments.production.github_environment == "admin-production" &&
      local.environments.development.github_environment == "admin-development"
    )
    error_message = "Admin GitHub environment names must not overlap Client App environments."
  }
}
