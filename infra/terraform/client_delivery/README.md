# Client delivery GitHub configuration

This Terraform root owns only the Client App GitHub environments:

- `client-development`, deployable only by `client-development-v*` tags;
- `client-production`, deployable only by `client-production-v*` tags;
- optional reviewers for production deployment approval.

It does not manage Admin Web, AWS, Google Play, App Store Connect, signing
credentials, or repository secrets.

Copy `backend.hcl.example` to ignored `backend.hcl`, copy
`terraform.tfvars.example` to ignored `terraform.tfvars`, set `GITHUB_TOKEN`
with repository environment administration access, then run:

```bash
terraform init -backend-config=backend.hcl
terraform plan
terraform apply
```

Add the Client signing and store secrets documented in
`.github/docs/android.md` and `.github/docs/ios.md` to both Client
environments after Terraform creates them.
