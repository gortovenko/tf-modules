output "secrets_arn" {
  value       = aws_secretsmanager_secret.app_secrets.arn
  description = "ARN of the secret stored in AWS Secrets Manager"

}

