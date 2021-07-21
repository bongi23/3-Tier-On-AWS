
resource "aws_autoscaling_group" "application" {
  tags = var.tags
  max_size            = var.app_server_max
  min_size            = var.app_server_min
  desired_capacity    = var.app_server_desired
  default_cooldown    = var.app_server_cooldown
  vpc_zone_identifier = var.app_server_subnets
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.application_targets.arn]

  launch_template {
    id      = aws_launch_template.application.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "public" {
  tags = var.tags
  max_size            = var.web_server_max
  min_size            = var.web_server_min
  desired_capacity    = var.web_server_desired
  default_cooldown    = var.web_server_cooldown
  vpc_zone_identifier = var.web_server_subnets
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.public_targets.arn]

  launch_template {
    id      = aws_launch_template.public.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "application" {
  tags = var.tags
  max_size            = var.app_server_max
  min_size            = var.app_server_min
  desired_capacity    = var.app_server_desired
  default_cooldown    = var.app_server_cooldown
  vpc_zone_identifier = var.app_server_subnets
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.application_targets.arn]

  launch_template {
    id      = aws_launch_template.application.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_group" "data" {
  tags = var.tags
  max_size            = var.db_replicas
  min_size            = var.db_replicas
  desired_capacity    = var.db_replicas
  default_cooldown    = var.db_cooldown
  vpc_zone_identifier = var.data_subnets
  health_check_type   = "ELB"
  target_group_arns   = [aws_lb_target_group.data_targets.arn]

  launch_template {
    id      = aws_launch_template.public.id
    version = "$Latest"
  }
}