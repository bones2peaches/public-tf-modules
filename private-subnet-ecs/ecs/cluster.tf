


resource "aws_ecs_cluster" "this" {
  name = "${var.project}-${var.env}-cluster"
  depends_on = [ aws_cloudwatch_log_group.this ]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.this.name
      }
    }
  }
}




