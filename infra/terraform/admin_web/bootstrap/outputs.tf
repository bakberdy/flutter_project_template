output "state_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "backend_hcl" {
  value = <<-EOT
    bucket       = "${aws_s3_bucket.terraform_state.bucket}"
    key          = "flutter-project-template/admin-web/terraform.tfstate"
    region       = "${var.aws_region}"
    use_lockfile = true
    encrypt      = true
  EOT
}
