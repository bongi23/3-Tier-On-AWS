# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "default" {
  for_each = aws_instance.default

  instance = each.value.id
  vpc      = true

  tags = var.tags
}