# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

resource "aws_lb" "public" {
  load_balancer_type               = "application"
  internal                         = false
  subnets                          = var.public_subnets

  tags = merge(var.tags, {
    Name = "Public",
    layer = "Public"
  })
}

resource "aws_lb" "application" {
  load_balancer_type               = "network"
  internal                         = true
  subnets                          = var.application_subnets
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = merge(var.tags, {
    Name = "Application",
    layer = "Application"
  })
}