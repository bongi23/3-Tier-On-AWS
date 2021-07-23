# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
resource "aws_nat_gateway" "default" {
  for_each = { for key in local.nat_gateways_data : key.availability_zone => key }

  allocation_id     = aws_eip.natgw_eip[each.value.availability_zone].id
  subnet_id         = aws_subnet.default[each.value.cidr_block].id
  connectivity_type = "public"
  tags              = merge(var.tags, { layer = lookup(each.value.tags, "layer", "NAT") })

  depends_on = [aws_eip.natgw_eip]
}