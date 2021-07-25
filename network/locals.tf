locals {
  ############## Subnets data #################
  public_subnets_data = [for cidr_block in var.public_subnet_cidrs : {
    availability_zone = var.availability_zones[index(var.public_subnet_cidrs, cidr_block) % length(var.availability_zones)]
    cidr_block        = cidr_block
    tags = merge({
      layer = "Public"
    }, var.tags)
  }]

  application_subnets_data = [for cidr_block in var.application_subnet_cidrs : {
    availability_zone = var.availability_zones[index(var.application_subnet_cidrs, cidr_block) % length(var.availability_zones)]
    cidr_block        = cidr_block
    tags = merge({
      layer = "Application"
    }, var.tags)
  }]

  data_subnets_data = [for cidr_block in var.data_subnet_cidrs : {
    availability_zone = var.availability_zones[index(var.data_subnet_cidrs, cidr_block) % length(var.availability_zones)]
    cidr_block        = cidr_block
    tags = merge({
      layer = "Data"
    }, var.tags)
  }]
  #################################################
  ############ NAT Gateway data ###################
  # this variable is used to keep the association between AZ and subnet, in order to
  # deploy the NAT GW in the correct subnets
  nat_gateways_data = [for i in range(min(length(var.availability_zones), length(var.public_subnet_cidrs))) : {
    availability_zone = var.availability_zones[i]
    cidr_block        = local.public_subnets_data[i].cidr_block
    tags              = var.tags
  }]

}