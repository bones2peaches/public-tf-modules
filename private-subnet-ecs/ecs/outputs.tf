output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "latest_task_arn" {
  value       = aws_ecs_task_definition.api_task.arn
  description = "The ARN of latest api arn"
}


