
output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = slice(
    [for subnet in aws_subnet.public : subnet.id],
    0,
    length(aws_subnet.public)
  )
}



output "private_subnets" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}
