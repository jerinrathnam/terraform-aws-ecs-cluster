output "ecs_service" {
  value       = aws_ecs_service.this[*]
  description = "Full details about ECS Services"
}

output "ecs_task_definition" {
  value       = aws_ecs_task_definition.this[*]
  description = "Full details about ECS Task Definitions"
}

output "ecr_repositories" {
  value       = var.create_ecr_repository ? aws_ecr_repository.this[*] : []
  description = "Full details about ECR Repositories"
}

output "cloudwatch_log_groups" {
  value       = var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[*] : []
  description = "Full details about Cloudwatch Log Groups"
}

output "ecr_repository_arns" {
  value       = var.create_ecr_repository ? aws_ecr_repository.this[*].arn : []
  description = "List of ARNs of ECR Repositories"
}

output "ecs_task_definition_arn" {
  value       = aws_ecs_task_definition.this[*].arn
  description = "List of ARNs of ECS Task Definitions"
}