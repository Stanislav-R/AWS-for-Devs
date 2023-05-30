### Creating S3 bucket and uploading multiple jar files to it ###
locals {
  jars_filepath = var.jars_filepath
}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = var.bucket_force_destroy
  tags = {
    Name = "exchange-s3-bucket"
  }
}

resource "aws_s3_object" "upload_file" {
  for_each = fileset(local.jars_filepath, "**/*.jar")
  bucket   = aws_s3_bucket.bucket.id
  key      = each.value
  source   = "${local.jars_filepath}/${each.value}"
  etag     = filemd5("${local.jars_filepath}/${each.value}")
}
