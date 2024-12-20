resource "aws_iam_role" "lambda" {
  name = "${var.lambda_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${var.lambda_name}-role"
  }
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "${var.lambda_name}-basic-execution"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_vpc_permissions" {
  name        = "${var.lambda_name}-vpc-permissions"
  description = "Permissions for Lambda to interact with VPC"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_policy" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_vpc_permissions.arn
}


resource "aws_iam_policy" "lambda_secrets_access" {
  name        = "lambda-secrets-access"
  description = "Allow Lambda to access Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = var.secrets_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_secrets_policy" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_secrets_access.arn
}

resource "aws_iam_policy" "ecs_secrets_access" {
  name        = "ecs-secrets-access"
  description = "Allow ECS tasks to read secrets from Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = var.secrets_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_secrets_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_secrets_access.arn
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.lambda_name}-ecs-task-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "ecs_autoscaling_permissions" {
  name        = "ecs-autoscaling-permissions"
  description = "Allow Application Auto Scaling to manage ECS services"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "application-autoscaling:DescribeScalableTargets",
          "application-autoscaling:RegisterScalableTarget",
          "application-autoscaling:DeregisterScalableTarget",
          "application-autoscaling:DescribeScalingPolicies",
          "application-autoscaling:PutScalingPolicy",
          "application-autoscaling:DeleteScalingPolicy"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_autoscaling_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_autoscaling_permissions.arn
}

resource "aws_iam_policy" "lambda_autoscaling_permissions" {
  name        = "lambda-autoscaling-permissions"
  description = "Allow Application Auto Scaling to manage Lambda concurrency"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "lambda:PutFunctionConcurrency",
          "lambda:DeleteFunctionConcurrency",
          "lambda:GetFunctionConcurrency",
          "application-autoscaling:DescribeScalableTargets",
          "application-autoscaling:RegisterScalableTarget",
          "application-autoscaling:DeregisterScalableTarget",
          "application-autoscaling:DescribeScalingPolicies",
          "application-autoscaling:PutScalingPolicy",
          "application-autoscaling:DeleteScalingPolicy"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_autoscaling_policy_attachment" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_autoscaling_permissions.arn
}



