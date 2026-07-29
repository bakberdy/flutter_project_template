# Tag-driven releases

Admin and Client deployments use the same tag naming convention but remain
separate pipelines, configurations, credentials, and GitHub environments.

## Tag contract

```text
<application>-<environment>-v<MAJOR.MINOR.PATCH>
```

Supported tags:

- `admin-development-v1.2.3`
- `admin-production-v1.2.3`
- `client-development-v1.2.3`
- `client-production-v1.2.3`

Every tag must point to the current default-branch HEAD. Its version must match
the corresponding `apps/<application>_app/pubspec.yaml` version before `+`.
There are no manual deployment triggers and release workflows never commit
version changes back to the repository.

## Separate pipelines

- `.github/workflows/admin-release.yml` handles only Admin Web.
- `.github/workflows/client-release.yml` handles only Client Android and iOS.
- `.github/workflows/pull-request-validation.yml` is the shared repository
  merge gate and does not deploy either application.

Development and production are isolated with these environments:

- `admin-development`
- `admin-production`
- `client-development`
- `client-production`

Production reviewer approvals can be configured independently for Admin and
Client.

## Setup for a repository created from this template

1. Apply `infra/terraform/admin_web` for Admin AWS and Admin GitHub
   environments.
2. Apply `infra/terraform/client_delivery` for Client GitHub environments.
3. Add Admin DNS records reported by Terraform.
4. Add Client signing and store secrets from `android.md` and `ios.md` to the
   matching Client environments.
5. Set the application version in the relevant `pubspec.yaml`, merge it through
   the protected default branch, then create and push the tag.

Example:

```bash
git tag client-production-v1.2.3
git push origin client-production-v1.2.3
```
