resource "aws_s3_bucket" "admin_web" {
  for_each = local.environments

  bucket        = "${var.project_name}-${each.key}-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
  force_destroy = false

  tags = {
    Environment = each.key
    Owner       = "admin-app"
  }
}

resource "aws_s3_bucket_public_access_block" "admin_web" {
  for_each = aws_s3_bucket.admin_web

  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "admin_web" {
  for_each = aws_s3_bucket.admin_web

  bucket = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "admin_web" {
  for_each = aws_s3_bucket.admin_web

  bucket = each.value.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "bootstrap_index" {
  for_each = aws_s3_bucket.admin_web

  bucket       = each.value.id
  key          = "releases/bootstrap/index.html"
  content      = "<!doctype html><html><body><h1>Admin deployment is not initialized</h1></body></html>"
  content_type = "text/html; charset=utf-8"
}

resource "aws_s3_object" "bootstrap_release" {
  for_each = aws_s3_bucket.admin_web

  bucket = each.value.id
  key    = "releases/bootstrap/release.json"
  content = jsonencode({
    artifact_digest    = "bootstrap"
    source_sha         = "bootstrap"
    target_environment = local.environments[each.key].github_environment
  })
  content_type = "application/json"
}
