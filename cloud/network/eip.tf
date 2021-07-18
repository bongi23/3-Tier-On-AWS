# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "natgw_eip" {
  for_each = toset(var.availability_zones)

  vpc  = true
  tags = var.tags

  depends_on = [aws_internet_gateway.default]
}