# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.arn
  port              = var.public_listener_port
  protocol          = var.public_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}