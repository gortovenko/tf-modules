resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}