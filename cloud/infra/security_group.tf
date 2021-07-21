resource "aws_security_group" "public" {
  tags = var.tags
  name        = "WebServerSG"
  description = "Allow web server traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Traffic to web server"
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