resource "aws_eip" "default" {
  for_each = aws_instance.default
  instance = aws_instance.default.id
  vpc = true

  tags = var.tags
}