variable "bucket" {
  type     = string
  nullable = false
}

resource "aws_s3_bucket" "backups" {
  bucket = var.bucket
}

resource "aws_s3_bucket_ownership_controls" "account" {
  bucket = aws_s3_bucket.backups.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "access" {
  bucket     = aws_s3_bucket.backups.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.account]

  lifecycle {
    ignore_changes = [acl]
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backups.id

  versioning_configuration {
    status = "Enabled"
  }
}

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
