# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "default" {
  for_each = var.ec2_cidr_az_mapping

  ami           = var.ami
  instance_type = var.instance_size

  associate_public_ip_address = var.associate_public_ip
  availability_zone           = ""
  subnet_id                   = ""
  vpc_security_group_ids      = concat(var.extra_sg_id, [aws_security_group.default.id])
  tags                        = var.tags
  key_name                    = aws_key_pair.default.key_name

}