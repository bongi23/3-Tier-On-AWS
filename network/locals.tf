locals {
  ############## Subnets data #################
  public_subnets_data = [for cidr_block in var.public_subnet_cidrs : {
    availability_zone = var.availability_zones[index(var.public_subnet_cidrs, cidr_block) % length(var.availability_zones)]
    cidr_block        = cidr_block
    tags = merge({
      layer = "Public"
    }, var.tags)
  }]
}