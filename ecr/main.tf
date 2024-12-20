resource "aws_ecr_repository" "quote" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }
}


resource "aws_ecr_lifecycle_policy" "quote_lifecycle" {
  repository = aws_ecr_repository.quote.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep the 'latest' image for production"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["latest"]
          countType     = "imageCountMoreThan"
          countNumber   = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
