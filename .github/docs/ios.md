# iOS CI/CD (step by step)

## Step 1 — `apps/client_app/ios/keys/.env` (local Fastlane)

Copy `apps/client_app/ios/keys/.env.example` → `apps/client_app/ios/keys/.env`. Paths are relative to `apps/client_app/ios/` unless absolute.

**Same names as GitHub for shared values** (see Step 6 for Actions-specific columns):


| Key                                            | Meaning                                 |
| ---------------------------------------------- | --------------------------------------- |
| `APP_STORE_CONNECT_API_KEY_PATH`               | Path to App Store Connect API `.p8`     |
| `APP_STORE_CONNECT_KEY_ID`                     | API key id                              |
| `APP_STORE_CONNECT_ISSUER_ID`                  | Issuer id                               |
| `IOS_TEAM_ID`                                  | Apple Developer Team ID                 |
| `IOS_BUILD_CERTIFICATE_PATH`                   | Distribution `.p12` path                |
| `IOS_BUILD_CERTIFICATE_PASSWORD`               | `.p12` password                         |
| `IOS_PROVISIONING_PROFILE_NAME_DEVELOPMENT`    | Exact profile name (development bundle) |
| `IOS_PROVISIONING_PROFILE_NAME_PRODUCTION`     | Exact profile name (production bundle)  |
| `IOS_BUILD_PROVISION_PROFILE_PATH_DEVELOPMENT` | Path to development `.mobileprovision`  |
| `IOS_BUILD_PROVISION_PROFILE_PATH_PRODUCTION`  | Path to production `.mobileprovision`   |


## Step 2 — App Store Connect API key

**App Store Connect → Users and Access → Integrations → App Store Connect API → Generate API Key.**

- Role: **App Manager** (or Admin).
- You get: `.p8` file → `APP_STORE_CONNECT_API_KEY_PATH` in `.env`, plus `APP_STORE_CONNECT_KEY_ID` and `APP_STORE_CONNECT_ISSUER_ID`.

## Step 3 — Distribution certificate (`.p12` + password)

1. **Keychain Access** → **Certificate Assistant** → **Request a Certificate From a Certificate Authority** → save the CSR to disk.
2. **developer.apple.com** → **Certificates** → add **Apple Distribution** → upload that CSR.
3. **Keychain** → **login** → find the new **Apple Distribution** cert → **Export** → set a password → save as `.p12` under `apps/client_app/ios/keys/`. Set `IOS_BUILD_CERTIFICATE_PATH` and `IOS_BUILD_CERTIFICATE_PASSWORD` in `.env` (and cert secrets in Step 6 for CI).

## Step 4 — Provisioning profiles (one per flavor)

**developer.apple.com** → **Profiles** → **Register a New Profile** → type **App Store** → pick each app ID (per flavor) → link the **Apple Distribution** cert from step 3 → download each `.mobileprovision`.

Use the profile **Name** exactly as in `IOS_PROVISIONING_PROFILE_NAME_`*; file paths in `IOS_BUILD_PROVISION_PROFILE_PATH_*`.

## Step 5 — Deploy locally (Fastlane + Makefile)

One-time: `cd apps/client_app/ios && bundle install`.

From **repo root**:

```bash
make client-ios-deploy-prod
# or: client-ios-deploy-dev
```

Runs `beta_production` / `beta_development` (IPA + TestFlight). Requires Step 1 `.env` and `CI` **unset** so Fastlane uses JSON for dart-defines (see table below).

## Step 6 — GitHub Actions secrets

**Repo → Settings → Secrets and variables → Actions → New repository secret.**


| Secret                                           | Value                                                                |
| ------------------------------------------------ | -------------------------------------------------------------------- |
| `APP_STORE_CONNECT_KEY_ID`                       | API key id                                                           |
| `APP_STORE_CONNECT_ISSUER_ID`                    | Issuer id                                                            |
| `APP_STORE_CONNECT_API_KEY`                      | Full `.p8` PEM, or base64 of that file (workflow writes a temp path) |
| `IOS_TEAM_ID`                                     | Apple Developer Team ID used for manual signing                       |
| `IOS_BUILD_CERTIFICATE_BASE64`                   | Base64 of `apps/client_app/ios/keys/cert.p12` (see commands below)                   |
| `IOS_BUILD_CERTIFICATE_PASSWORD`                 | `.p12` password                                                      |
| `IOS_BUILD_PROVISION_PROFILE_BASE64_DEVELOPMENT` | Base64 of dev `.mobileprovision` (see commands below)                |
| `IOS_PROVISIONING_PROFILE_NAME_DEVELOPMENT`      | Exact profile name (must match file)                                 |
| `IOS_BUILD_PROVISION_PROFILE_BASE64_PRODUCTION`  | Base64 of production `.mobileprovision` (see commands below)         |
| `IOS_PROVISIONING_PROFILE_NAME_PRODUCTION`       | Exact production profile name                                        |


**Base64 for GitHub (macOS, run from repository root):** use the same paths as in `apps/client_app/ios/keys/.env` (`IOS_BUILD_PROVISION_PROFILE_PATH_`*, `IOS_BUILD_CERTIFICATE_PATH`), or the paths below if they match your files. Paste the clipboard output into the secret value (no quotes).

```bash
# Distribution .p12 → secret IOS_BUILD_CERTIFICATE_BASE64
base64 -i apps/client_app/ios/keys/cert.p12 | tr -d '\n' | pbcopy

# Development .mobileprovision → secret IOS_BUILD_PROVISION_PROFILE_BASE64_DEVELOPMENT
base64 -i apps/client_app/ios/keys/profiles/clientappdevelopmentprofile.mobileprovision | tr -d '\n' | pbcopy

# Production .mobileprovision → secret IOS_BUILD_PROVISION_PROFILE_BASE64_PRODUCTION
base64 -i apps/client_app/ios/keys/profiles/clientappproductionprofile.mobileprovision | tr -d '\n' | pbcopy
```

If your filenames differ, only change the path after `-i` (match `IOS_BUILD_PROVISION_PROFILE_PATH_DEVELOPMENT` etc.). On Linux, use `base64 -w0 file | xclip -selection clipboard` (or `wl-copy`) instead of `tr … | pbcopy`.

**Build config (flavor-scoped, not iOS-only):** same JSON keys as `config/config.example.json` (`API_URL`, `ENVIRONMENT`, …). **Secret name = `<FLAVOR>_<KEY>`** with **FLAVOR** uppercase: `DEVELOPMENT` | `PRODUCTION` (matches Fastlane `env_suffix`). The secret **value** is the same string as in the matching `config/config.<flavor>.json` for that key. Local builds still use those files; CI passes `--dart-define` from these secrets.


| Secret                                  | JSON field in that flavor’s `config.*.json` |
| --------------------------------------- | ------------------------------------------- |
| `DEVELOPMENT_API_URL`                   | `API_URL`                                   |
| `DEVELOPMENT_ENVIRONMENT`               | `ENVIRONMENT`                               |
| `DEVELOPMENT_ENABLE_LOGGING`            | `ENABLE_LOGGING`                            |
| `DEVELOPMENT_ENABLE_ANALYTICS`          | `ENABLE_ANALYTICS`                          |
| `DEVELOPMENT_ENABLE_CRASHLYTICS`        | `ENABLE_CRASHLYTICS`                        |
| `DEVELOPMENT_CONNECT_TIMEOUT_SECONDS`   | `CONNECT_TIMEOUT_SECONDS`                   |
| `DEVELOPMENT_RECEIVE_TIMEOUT_SECONDS`   | `RECEIVE_TIMEOUT_SECONDS`                   |
| `DEVELOPMENT_SEND_TIMEOUT_SECONDS`      | `SEND_TIMEOUT_SECONDS`                      |
| `PRODUCTION_API_URL`                    | `API_URL`                                   |
| `PRODUCTION_ENVIRONMENT`                | `ENVIRONMENT`                               |
| `PRODUCTION_ENABLE_LOGGING`             | `ENABLE_LOGGING`                            |
| `PRODUCTION_ENABLE_ANALYTICS`           | `ENABLE_ANALYTICS`                          |
| `PRODUCTION_ENABLE_CRASHLYTICS`         | `ENABLE_CRASHLYTICS`                        |
| `PRODUCTION_CONNECT_TIMEOUT_SECONDS`    | `CONNECT_TIMEOUT_SECONDS`                   |
| `PRODUCTION_RECEIVE_TIMEOUT_SECONDS`    | `RECEIVE_TIMEOUT_SECONDS`                   |
| `PRODUCTION_SEND_TIMEOUT_SECONDS`       | `SEND_TIMEOUT_SECONDS`                      |


For a given workflow run, the workflow `inputs.flavor` must have its profile pair, the build-config pair for that flavor, and all shared rows above.

## Step 7 — CI: what runs and how

- **Workflow:** `.github/workflows/ios-upload-to-testflight.yml` (reusable). It sets `CI=true`, resolves the workspace with Swift Package Manager enabled, verifies that `client_app` has no Podfile, Pods directory, or Pods xcconfig references, installs Fastlane from `apps/client_app/ios/Gemfile`, then decodes signing + API key and runs `cd apps/client_app/ios && bundle exec fastlane beta_<flavor>`. For **tag releases** from `release-on-publish`, if the **GitHub Release** has a **description**, the `release_body` **input** provides the first **4,000** characters as TestFlight **What to Test** (same string as the Android job, passed from the parent workflow; manual `workflow_dispatch` has no `release_body` unless you set it, so notes are skipped).
- **Tag releases:** `.github/workflows/release-on-publish.yml` calls that workflow with `flavor: <prefix from tag>` and `release_body` after the version step. Pushing a release tag runs the iOS job if the rest of the release pipeline is set up; you need the secrets for that tag’s flavor (e.g. `production`) plus the shared App Store / signing rows from Step 6.
- **Artifact:** on success, the job uploads `apps/client_app/build/ios/ipa/*.ipa` as `ios-<flavor>-ipa`.
- **Other flavors in CI:** add a workflow (or `workflow_dispatch` input) that calls `ios-upload-to-testflight.yml` with `flavor: development` and `secrets: inherit`. Only the secrets for that flavor need to be non-empty for that run (plus shared keys).

## Reference (quick)


| Flutter flavor | Bundle ID                             | Config JSON (local / `dart-define-from-file`) |
| -------------- | ------------------------------------- | --------------------------------------------- |
| `development`  | `com.bakberdi.template.development` | `config/config.development.json`          |
| `production`   | `com.bakberdi.template`             | `config/config.production.json`           |



| Fastlane lane      | Flavor      |
| ------------------ | ----------- |
| `beta_development` | development |
| `beta_production`  | production  |


**Dart / compile-time defines:** app-owned `AppConfig` reads required values with `String.fromEnvironment(...)` from `apps/client_app/lib/src/common/config/app_config.dart`. **Local:** `config/*.json`. **CI:** secrets `<FLAVOR>_<KEY>` (see Step 6). New key: add to `config.example.json`, `DART_DEFINE_KEYS` in `ios/fastlane/helpers.rb`, `String.fromEnvironment(...)` in Dart, and the workflow `env` for the iOS job.

**Android CI:** [.github/docs/android.md](android.md)
