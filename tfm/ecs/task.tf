resource "aws_ecs_task_definition" "this" {
  depends_on = [ aws_iam_role.exc_task.arn , ws_iam_role.exc_role.arn  , aws_cloudwatch_log_group.this ]
  family                   = "${var.project}-${var.env}-api-task-family"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory = var.memory

  task_role_arn      = aws_iam_role.exc_task.arn
  execution_role_arn = aws_iam_role.exc_role.arn

  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "${var.aws_account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.ecr_name}:${var.image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
      environment = [
        {
          "name" : "DB_NAME",
          "value" : "${var.db_name}"
        },
        {
          "name" : "DB_HOST",
          "value" : "${var.db_hostname}"
        },
        {
          "name" : "DB_PORT",
            "value" : "${var.db_port}"
        },
      ]
      secrets = [
        {
          "name" : "DB_PASSWORD",
          "valueFrom" : "${var.rds_secret_arn}"
      }]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group"  = "true"
          "awslogs-region"        = "${data.aws_region.current.name}"
          "awslogs-group"         = "${aws_cloudwatch_log_group.this.name}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])


}