resource "aws_secretsmanager_secret" "app_secrets" {
  name        = var.secrets_name
  description = "Secrets for ${var.environment}-environment"

  tags = {
    Environment = var.environment
    Name        = var.secrets_name
  }
}

resource "aws_secretsmanager_secret_version" "app_secrets_version" {
  secret_id = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode({
    CACHE_PROVIDER  = var.cache_provider,
    RUN_LOCAL_MODE  = var.run_local_mode,
    ELASTICACHE_URL = var.elasticache_url,
    SERVER_ADDRESS  = var.server_address,
    BASE_URL        = var.base_url,
    DEFAULT_COUNT   = var.default_count
  })
}




