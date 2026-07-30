resource "aws_iam_openid_connect_provider" "github" {
  count = var.github_oidc_provider_arn == null ? 1 : 0

  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "publisher_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "${local.github_oidc_repository}:ref:refs/tags/admin-development-v*",
        "${local.github_oidc_repository}:ref:refs/tags/admin-production-v*",
      ]
    }
  }
}

resource "aws_iam_role" "publisher" {
  name               = "${var.project_name}-publisher"
  assume_role_policy = data.aws_iam_policy_document.publisher_assume_role.json
}

data "aws_iam_policy_document" "publisher" {
  statement {
    sid     = "ListAdminReleasePaths"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    resources = [
      for bucket in aws_s3_bucket.admin_web : bucket.arn
    ]
    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["artifacts/sha256/*", "releases/*"]
    }
  }

  statement {
    sid     = "PublishImmutableAdminArtifacts"
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:PutObject"]
    resources = flatten([
      for bucket in aws_s3_bucket.admin_web : [
        "${bucket.arn}/artifacts/sha256/*",
        "${bucket.arn}/releases/*",
      ]
    ])
  }
}

resource "aws_iam_role_policy" "publisher" {
  name   = "publish-admin-web-artifacts"
  role   = aws_iam_role.publisher.id
  policy = data.aws_iam_policy_document.publisher.json
}

data "aws_iam_policy_document" "deployer_assume_role" {
  for_each = local.environments

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["${local.github_oidc_repository}:environment:${each.value.github_environment}"]
    }
  }
}

resource "aws_iam_role" "deployer" {
  for_each = local.environments

  name               = "${var.project_name}-${each.key}-deployer"
  assume_role_policy = data.aws_iam_policy_document.deployer_assume_role[each.key].json
}

data "aws_iam_policy_document" "deployer" {
  for_each = local.environments

  statement {
    sid     = "ReadApprovedAdminRelease"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.admin_web[each.key].arn}/artifacts/sha256/*",
      "${aws_s3_bucket.admin_web[each.key].arn}/releases/*",
    ]
  }

  statement {
    sid       = "ReadAdminReleaseMetadata"
    effect    = "Allow"
    actions   = ["cloudfront-keyvaluestore:DescribeKeyValueStore", "cloudfront-keyvaluestore:GetKey", "cloudfront-keyvaluestore:PutKey"]
    resources = [aws_cloudfront_key_value_store.active_release[each.key].arn]
  }

  statement {
    sid       = "InvalidateAdminDistribution"
    effect    = "Allow"
    actions   = ["cloudfront:CreateInvalidation"]
    resources = [aws_cloudfront_distribution.admin_web[each.key].arn]
  }
}

resource "aws_iam_role_policy" "deployer" {
  for_each = local.environments

  name   = "deploy-admin-web-${each.key}"
  role   = aws_iam_role.deployer[each.key].id
  policy = data.aws_iam_policy_document.deployer[each.key].json
}
