
resource "aws_security_group" "public" {
  tags        = var.tags
  name        = "WebServerSG"
  description = "Allow web server traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic from internet"
    from_port   = var.public_listener_port
    to_port     = var.public_listener_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH to web server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_sources
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "application" {
  tags        = var.tags
  name        = "AppServerSG"
  description = "Allow app server traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic from web server"
    from_port   = var.public_listener_port
    to_port     = var.public_listener_port
    protocol    = "tcp"
    cidr_blocks = var.public_subnets_cidr
  }

  ingress {
    description = "SSH to web server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_sources
  }

  egress {
    description = "Traffic to web server"
    from_port   = var.public_listener_port
    to_port     = var.public_listener_port
    protocol    = "tcp"
    cidr_blocks = var.public_subnets_cidr
  }

  egress {
    description = "Traffic to db server"
    from_port   = var.data_listener_port
    to_port     = var.data_listener_port
    protocol    = "tcp"
    cidr_blocks = var.data_subnets_cidr
  }

}


resource "aws_security_group" "data" {
  tags        = var.tags
  name        = "AppServerSG"
  description = "Allow app server traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic from app server"
    from_port   = var.application_listener_port
    to_port     = var.application_listener_port
    protocol    = "tcp"
    cidr_blocks = var.application_subnets_cidr
  }

  ingress {
    description = "SSH to db server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_sources
  }

  egress {
    description = "Traffic to app server"
    from_port   = var.application_listener_port
    to_port     = var.application_listener_port
    protocol    = "tcp"
    cidr_blocks = var.application_subnets_cidr
  }

}