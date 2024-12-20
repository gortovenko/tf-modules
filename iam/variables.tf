variable "lambda_name" {
  type = string
}

variable "secrets_arn" {
  type = string

}

variable "ecs_task_role_name" {
  type        = string
  description = "Name of the ECS Task Role"
}
