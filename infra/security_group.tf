# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "default" {
  tags        = var.tags
  name        = "WebServerSG"
  description = "Allow web server traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic from internet"
    from_port   = var.public_listener_port
    to_port     = var.public_listener_port
    protocol    = "tcp"
    cidr_blocks = var.ingress_traffic_cidrs
  }

  ingress {
    description = "Traffic for DB"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.db_allowed_cidr
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
    cidr_blocks = var.external_traffic_cidrs
  }

}
