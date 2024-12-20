variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "s3_bucket_name" {
  description = "A descriptive name for the S3 bucket tags"
  type        = string
}

variable "environment" {
  description = "The environment for the S3 bucket (e.g., dev, staging, production)"
  type        = string
}
