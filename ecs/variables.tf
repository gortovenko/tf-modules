variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "task_family" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "secrets_arn" {
  type        = string
  description = "ARN of the secret in AWS Secrets Manager"
}