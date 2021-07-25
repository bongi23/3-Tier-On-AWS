# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags   = var.tags
}