variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "vpc_subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "environment_variables" {
  type = map(string)
}

variable "source_path" {
  type = string
}

variable "filename" {
  type = string
}

variable "reserved_concurrent_executions" {
  type        = number
  default     = 5
  description = "The maximum number of simultaneous executions for the Lambda function"
}

variable "s3_bucket" {
  type = string
}

variable "s3_key" {
  type = string
}

