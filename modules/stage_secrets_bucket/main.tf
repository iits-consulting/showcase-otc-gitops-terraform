resource "opentelekomcloud_obs_bucket_object" "stage_secrets" {
  key = "stage-secrets"
  encryption = true
  content = jsonencode(var.stage_secrets)
  content_type = "application/json"
  bucket = opentelekomcloud_obs_bucket.stage_secrets.bucket
  kms_key_id = "arn:aws:kms:eu-de:${var.kms_domain_id}:key/${var.kms_key_id}"
}

resource "opentelekomcloud_obs_bucket" "stage_secrets" {
  bucket = var.bucket_name
  acl = "private"
  versioning = true
  tags = var.tags
}

resource "opentelekomcloud_obs_bucket_policy" "only_encrypted" {
  bucket = opentelekomcloud_obs_bucket.stage_secrets.id
  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid = "EnforceEncryption"
        Effect = "Deny"
        Principal = {
          "AWS" : [
            "*"]
        }
        Action = [
          "s3:PutObject"],
        Resource = [
          "arn:aws:s3:::${opentelekomcloud_obs_bucket.stage_secrets.bucket}/*"]
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" = [
              "aws:kms"]
          }
        }
      }
    ]
  })
}