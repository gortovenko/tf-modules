output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "primary_endpoint_port" {
  value = aws_elasticache_replication_group.this.port
}
