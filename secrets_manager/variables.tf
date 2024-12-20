variable "secrets_name" {
  type        = string
  description = "Name of the secret in AWS Secrets Manager"
}

variable "cache_provider" {
  type        = string
  description = "Cache provider (e.g., elasticache)"
}

variable "run_local_mode" {
  type        = string
  description = "Run in local mode (true/false)"
}

variable "elasticache_url" {
  type        = string
  description = "ElastiCache connection URL"
}

variable "server_address" {
  type        = string
  description = "Server address for the application"
}

variable "base_url" {
  type        = string
  description = "Base URL for the scraper"
}

variable "default_count" {
  type        = number
  description = "Default count for the scraper"
}

variable "environment" {
  type        = string
  description = "Environment for the deployment (e.g., dev, staging, prod)"
}


