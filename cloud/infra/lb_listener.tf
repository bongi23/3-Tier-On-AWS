# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public.arn
  port              = var.public_listener_port
  protocol          = var.public_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_targets.arn
  }
}

resource "aws_lb_listener" "application_listener" {
  load_balancer_arn = aws_lb.application.arn
  port              = var.application_listener_port
  protocol          = var.application_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_targets.arn
  }
}