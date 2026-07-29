# Admin Web Terraform state bootstrap

This root creates only the versioned, encrypted S3 bucket used by the Admin Web
Terraform backend. Run it once with local state:

```bash
terraform init
terraform apply
terraform output -raw backend_hcl
```

Copy the output into the ignored parent `backend.hcl`. Do not commit state or
credentials.
