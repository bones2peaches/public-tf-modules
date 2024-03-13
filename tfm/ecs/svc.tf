
resource "aws_ecs_service" "this" {
  depends_on = [ aws_lb_target_group.this,aws_ecs_cluster.this , aws_ecs_task_definition.this , aws_security_group.svc  ]
  name                 = "${var.project}-${var.env}-ecs-service"
  cluster              = aws_ecs_cluster.this.arn
  task_definition      = aws_ecs_task_definition.this.arn
  desired_count        = 1
  launch_type          = "FARGATE"
  force_new_deployment = true


  network_configuration {
    subnets         = var.service_subnets
    security_groups = [aws_security_group.svc.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.health_check_port
  }


}