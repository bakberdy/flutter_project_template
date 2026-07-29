check "admin_domain_contract" {
  assert {
    condition = (
      local.environments.production.domain == "admin.bakberdi.dev" &&
      local.environments.development.domain == "dev.admin.bakberdi.dev"
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
