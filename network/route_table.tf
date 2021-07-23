locals {
  public_rt_data = local.public_subnets_data
}

# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public_rt" {
  for_each = { for key in local.public_rt_data : key.cidr_block => key }

  vpc_id = aws_vpc.default.id
  tags   = merge(each.value.tags, { Name = format("%s-%s", lookup(each.value.tags, "layer", ""), each.value.availability_zone) })

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
}