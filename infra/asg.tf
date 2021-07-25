# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "application" {
  name = "AppServer ASG"
  tags                = [var.tags]
  max_size            = var.application_max
  min_size            = var.application_min
  desired_capacity    = var.application_desired
  default_cooldown    = var.application_cooldown
  vpc_zone_identifier = var.application_subnets
  health_check_type   = "EC2"
  target_group_arns   = [aws_lb_target_group.application_targets.arn]

  launch_template {
    id      = aws_launch_template.application.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "public" {
  name = "WebServer ASG"

  tags                = [var.tags]
  max_size            = var.web_server_max
  min_size            = var.web_server_min
  desired_capacity    = var.web_server_desired
  default_cooldown    = var.web_server_cooldown
  vpc_zone_identifier = var.public_subnets
  health_check_type   = "EC2"
  target_group_arns   = [aws_lb_target_group.public_targets.arn]

  launch_template {
    id      = aws_launch_template.public.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "data" {
  name = "DatabaseServer ASG"

  tags                = [var.tags]
  max_size            = var.db_replicas
  min_size            = var.db_replicas
  desired_capacity    = var.db_replicas
  default_cooldown    = var.db_cooldown
  vpc_zone_identifier = var.data_subnets
  health_check_type   = "EC2"
  target_group_arns   = [aws_lb_target_group.data_targets.arn]

  launch_template {
    id      = aws_launch_template.application.id
    version = "$Latest"
  }
}
