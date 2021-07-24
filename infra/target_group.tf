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

resource "aws_lb_target_group_attachment" "test" {
  for_each = aws_instance.default

  target_group_arn = aws_lb_target_group.default.arn
  target_id        = each.value.id
  port             = var.public_listener_port
}