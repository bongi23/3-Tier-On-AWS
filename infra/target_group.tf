# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "default" {
  port                 = var.public_listener_port
  vpc_id               = var.vpc_id
  deregistration_delay = 60
  protocol             = var.public_listener_protocol

  #health_check {
  #  protocol = "HTTP"
  #}

  tags = var.tags
}
