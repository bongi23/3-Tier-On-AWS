locals {
  tags = {
    Project = "Satispay"
    Env     = "Prod"
    Author  = "Andrea Bongiorno"
  }
}

module "network" {
  source              = "./network"
  vpc_name            = "Satispay"
  public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_cidr_block      = "10.0.0.0/18"
  tags                = local.tags
}

module "infra" {
  source = "./infra"
  vpc_id = module.network.vpc.id

  # Subnets IDs
  public_subnets = [for subnet in module.network.public_subnets : subnet.id]

  #Subnets CIDRs
  public_subnets_cidr = [for subnet in module.network.public_subnets : subnet.cidr_block]

  ec2_cidr_az_mapping = { for subnet in module.network.public_subnets: subnet.availability_zone => subnet.id }

  ssh_pubkey             = file("id_rsa.pub")
  ssh_sources            = ["0.0.0.0/0"]
  external_traffic_cidrs = ["0.0.0.0/0"]
  ingress_traffic_cidrs  = ["0.0.0.0/0"]

  tags = local.tags

}