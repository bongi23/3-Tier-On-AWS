# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "default" {
  load_balancer_type = "application"
  internal           = false
  subnets            = var.public_subnets
  security_groups = [aws_security_group.default.id]
  tags = merge(var.tags, {
    layer = "Public"
  })
}