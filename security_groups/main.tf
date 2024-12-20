resource "aws_security_group" "lambda" {
  name        = var.lambda_sg_name
  description = "Security group for Lambda"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.lambda_sg_name
  }
}

resource "aws_security_group" "redis" {
  name        = var.redis_sg_name
  description = "Security group for Redis"
  vpc_id      = var.vpc_id
  ingress {
    protocol        = "tcp"
    from_port       = var.redis_port
    to_port         = var.redis_port
    security_groups = [aws_security_group.lambda.id, aws_security_group.ecs.id]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.redis_sg_name
  }
}

resource "aws_security_group" "ecs" {
  name        = var.ecs_sg_name
  description = "Security group for ECS"
  vpc_id      = var.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.ecs_sg_name
  }
}


