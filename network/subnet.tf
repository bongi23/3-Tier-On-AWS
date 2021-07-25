# Local variables are defined into locals.tf
# subnets data local variables are lists. These lists contain objects of the following type:
#
# {
#   cidr_block = string
#   availability_zone = string
#   tags = map(string)
# }
#

# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public" {
  for_each          = { for key in local.public_subnets_data : key.cidr_block => key }
  vpc_id            = aws_vpc.default.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags              = each.value.tags
}

resource "aws_subnet" "application" {
  for_each          = { for key in local.application_subnets_data : key.cidr_block => key }
  vpc_id            = aws_vpc.default.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags              = each.value.tags
}

resource "aws_subnet" "data" {
  for_each          = { for key in local.data_subnets_data : key.cidr_block => key }
  vpc_id            = aws_vpc.default.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags              = each.value.tags
}