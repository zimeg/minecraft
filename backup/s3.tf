# https://opentofu.org/docs/language/values/variables/
variable "bucket" {
  type     = string
  nullable = false
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "backups" {
  bucket = var.bucket
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "account" {
  bucket = aws_s3_bucket.backups.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_acl
resource "aws_s3_bucket_acl" "access" {
  bucket     = aws_s3_bucket.backups.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.account]

  lifecycle {
    ignore_changes = [acl]
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backups.id

  versioning_configuration {
    status = "Enabled"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration
resource "aws_s3_bucket_intelligent_tiering_configuration" "archives" {
  bucket = aws_s3_bucket.backups.id
  name   = "archives"

  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 90
  }

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
}
