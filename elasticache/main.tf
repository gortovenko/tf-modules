resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.cluster_id}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.cluster_id
  description                = "Redis replication group"
  engine                     = "redis"
  engine_version             = var.engine_version
  node_type                  = "cache.t3.micro"
  num_cache_clusters         = 1
  parameter_group_name       = "default.redis6.x"
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = var.sg_ids
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  maintenance_window         = "fri:03:00-fri:04:00"
  automatic_failover_enabled = false
}
