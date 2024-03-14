output "db_instance_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_hostname" {
  value = split(":", aws_db_instance.default.endpoint)[0]
}

output "db_port" {
  value = var.db_port
}

output "db_user" {
  value = var.db_user
}

output "db_instance_secret_arn" {
  value       = aws_db_instance.default.master_user_secret[0].secret_arn
  description = "The ARN of the secret associated with the RDS instance"
}

output "secret_arn" {
  value = aws_db_instance.default.master_user_secret[0].secret_arn 
}

output "kms_arn" {
  value = aws_kms_key.postgres_kms.arn
} 

output "kms_sm_policy_arn"{
  value = aws_iam_policy.this.arn
}