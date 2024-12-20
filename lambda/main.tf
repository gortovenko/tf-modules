resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = var.filename
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime
  publish       = true
  timeout       = 10
  memory_size   = 128


  reserved_concurrent_executions = var.reserved_concurrent_executions
  environment {
    variables = var.environment_variables

  }

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }
}




output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

