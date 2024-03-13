output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "exec_role_name" {
  value = aws_iam_role.exc_role.name
}

output "exec_role_arn" {
  value = aws_iam_role.exc_role.arn
}

output "task_role_name" {
  value = aws_iam_role.task_role.name
}

output "task_role_arn" {
  value = aws_iam_role.task_role.arn
}

output "latest_task_arn" {
  value       = aws_ecs_task_definition.api_task.arn
  description = "The ARN of latest api arn"
}


