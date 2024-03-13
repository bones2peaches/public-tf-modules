resource "aws_iam_role" "exc_role" {
  name = "${var.project}-${var.env}-ecs-exc-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_logs_policy_attachment" {
  depends_on = [ aws_iam_policy.logs ]

  role       = aws_iam_role.exc_role.name
  policy_arn = aws_iam_policy.logs.arn
}


resource "aws_iam_role_policy_attachment" "exec_attachments" {
  count = length(var.exec_policies)
  depends_on = [ aws_iam_role.exc_role ]


  role       = aws_iam_role.exc_role.name
  policy_arn = var.exec_policies[count.index]
}


resource "aws_iam_role" "task_role" {
  name = "${var.project}-${var.env}-ecs-task-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "task_attachments" {
  count = length(var.task_policies)
  depends_on = [ aws_iam_role.task_role ]


  role       = aws_iam_role.task_role.name
  policy_arn = var.task_policies[count.index]
}