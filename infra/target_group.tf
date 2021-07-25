# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "application_targets" {
  port                 = var.application_listener_port
  vpc_id               = var.vpc_id
  deregistration_delay = 60
  protocol             = var.application_listener_protocol

  #health_check {
  #  protocol = "TCP"
  #}

  tags = var.tags
}

resource "aws_lb_target_group" "public_targets" {
  port                 = var.public_listener_port
  vpc_id               = var.vpc_id
  deregistration_delay = 60
  protocol             = var.public_listener_protocol

  #health_check {
  #  protocol = "HTTP"
  #}

  tags = var.tags
}


resource "aws_lb_target_group" "data_targets" {
  port                 = var.data_listener_port
  vpc_id               = var.vpc_id
  deregistration_delay = 60
  protocol             = var.data_listener_protocol

  #health_check {
  #  protocol = "TCP"
  #}

  tags = var.tags
}