locals {
  public_rt_assoc_data = local.public_subnets_data
}

# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "public_rt_assoc" {
  for_each       = { for key in local.public_rt_assoc_data : key.cidr_block => key }
  route_table_id = aws_route_table.public_rt[each.key].id
  subnet_id      = aws_subnet.default[each.key].id
}
