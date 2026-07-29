resource "aws_cloudfront_key_value_store" "active_release" {
  for_each = local.environments

  name    = "${var.project_name}-${each.key}-active-release"
  comment = "Active immutable Admin Web release for ${each.key}"
}

resource "aws_cloudfrontkeyvaluestore_key" "active_release" {
  provider = aws.us_east_1
  for_each = local.environments

  key_value_store_arn = aws_cloudfront_key_value_store.active_release[each.key].arn
  key                 = "active_release"
  value               = "bootstrap"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_acm_certificate" "admin_web" {
  provider = aws.us_east_1
  for_each = local.environments

  domain_name       = each.value.domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "admin_web" {
  provider = aws.us_east_1
  for_each = local.environments

  certificate_arn = aws_acm_certificate.admin_web[each.key].arn

  timeouts {
    create = "60m"
  }
}

resource "aws_cloudfront_origin_access_control" "admin_web" {
  for_each = local.environments

  name                              = "${var.project_name}-${each.key}"
  description                       = "Private S3 access for Admin Web ${each.key}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_function" "release_router" {
  for_each = local.environments

  name                         = "${var.project_name}-${each.key}-router"
  runtime                      = "cloudfront-js-2.0"
  comment                      = "Route Admin requests to the active immutable release"
  publish                      = true
  key_value_store_associations = [aws_cloudfront_key_value_store.active_release[each.key].arn]
  code                         = file("${path.module}/functions/admin_release_router.js")
}

resource "aws_cloudfront_response_headers_policy" "security" {
  for_each = local.environments

  name = "${var.project_name}-${each.key}-security"
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "SAMEORIGIN"
      override     = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override        = true
    }
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains         = true
      override                   = true
      preload                    = true
    }
  }
}

resource "aws_cloudfront_distribution" "admin_web" {
  for_each = local.environments

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Admin Web ${each.key}"
  default_root_object = "index.html"
  aliases             = [each.value.domain]
  price_class         = "PriceClass_100"

  origin {
    domain_name              = aws_s3_bucket.admin_web[each.key].bucket_regional_domain_name
    origin_id                = "admin-web-s3-${each.key}"
    origin_access_control_id = aws_cloudfront_origin_access_control.admin_web[each.key].id
  }

  default_cache_behavior {
    target_origin_id           = "admin-web-s3-${each.key}"
    viewer_protocol_policy     = "redirect-to-https"
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD", "OPTIONS"]
    compress                   = true
    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security[each.key].id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.release_router[each.key].arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.admin_web[each.key].certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_s3_bucket_policy" "admin_web" {
  for_each = local.environments

  bucket = aws_s3_bucket.admin_web[each.key].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudFrontReadOnly"
      Effect    = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.admin_web[each.key].arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.admin_web[each.key].arn
        }
      }
    }]
  })
}
