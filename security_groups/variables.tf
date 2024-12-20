variable "vpc_id" {
  type = string
}

variable "lambda_sg_name" {
  type = string
}

variable "redis_sg_name" {
  type = string
}

variable "redis_port" {
  type = number
}

variable "ecs_sg_name" {
  type = string
}
