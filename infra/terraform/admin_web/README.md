# Admin Web infrastructure

This Terraform root owns only Flutter Admin Web infrastructure. Domain names
come from the `domains` input, for example:

- `admin.example.com` for production;
- `dev.admin.example.com` for development;
- private, versioned S3 buckets with immutable artifacts and releases;
- CloudFront distributions and ACM certificates;
- CloudFront KeyValueStore based atomic release selection;
- separate GitHub OIDC publish/deploy roles;
- `admin-development` and `admin-production` GitHub Environments and variables;
- the shared Client/Admin `pull-request-validation` repository ruleset.

It never creates or imports Client App resources. DNS is hosted outside AWS and
is intentionally not managed by this root.

Admin deployment is triggered only by `admin-development-v*` and
`admin-production-v*` tags. Client environments are managed separately in
`infra/terraform/client_delivery`.

## Apply

1. Create the remote state bucket from [`bootstrap`](bootstrap/README.md).
2. Copy `backend.hcl.example` to ignored `backend.hcl` and fill its values.
3. Copy `terraform.tfvars.example` to ignored `terraform.tfvars`.
4. Set `GITHUB_TOKEN` with environment, variable and ruleset administration
   access.
5. Authenticate Terraform to AWS without static credentials.
6. Create the certificates first:

```bash
terraform init -backend-config=backend.hcl
terraform apply -target=aws_acm_certificate.admin_web
terraform output -json acm_validation_records
```

7. Add the displayed ACM validation CNAME records to the external DNS
   provider and wait until ACM reports `ISSUED`.
8. Run the complete plan and apply:

```bash
terraform plan
terraform apply
terraform output -json admin_dns_records
```

9. Add the displayed Admin CNAME records to the external DNS provider. Do not
   hardcode CloudFront IP addresses as A records.

The CloudFront certificates are created in `us-east-1`, as required by
CloudFront. Workload buckets remain in `aws_region`.

The initial active release is `bootstrap`. A deployment uploads an immutable
release and changes only the `active_release` KeyValueStore entry. Terraform
ignores the runtime value so a later apply does not roll the app back.
