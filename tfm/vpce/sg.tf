resource "aws_security_group" "this" {
  name        = "${var.project}-${var.env}-vpce-sg"
  description = "allow connections from ecs task and testing to get access resources in private subnet"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = var.allowed_sgs
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}