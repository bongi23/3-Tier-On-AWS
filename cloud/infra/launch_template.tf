# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
resource "aws_launch_template" "application" {
  tags = var.tags

  description = "Launch template for the application server."

  update_default_version = true
  image_id               = var.app_server_ami
  instance_type          = var.app_server_instance_size

  iam_instance_profile {
    name = aws_iam_instance_profile.application.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.application.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
}


resource "aws_launch_template" "public" {
  tags = var.tags

  description = "Launch template for the web server."

  update_default_version = true
  image_id               = var.web_server_ami
  instance_type          = var.web_server_instance_size

  iam_instance_profile {
    name = aws_iam_instance_profile.public.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.public.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
}


resource "aws_launch_template" "public" {
  tags = var.tags

  description = "Launch template for the web server."

  update_default_version = true
  image_id               = var.data_ami
  instance_type          = var.data_instance_size

  iam_instance_profile {
    name = aws_iam_instance_profile.data.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.data.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
}