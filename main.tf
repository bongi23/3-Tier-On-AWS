locals {
  tags = {
    Project = "Satispay"
    Env     = "Dev"
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
  subnets_cidr = [for subnet in module.network.public_subnets : subnet.cidr_block]
  # Mapping from az to subnet cidr, it is used to deploy EC2 in the correct subnets
  ec2_cidr_az_mapping = { for subnet in module.network.public_subnets : subnet.availability_zone => subnet.id }
  # Public key to be imported to AWS, allows you to use your own SSH private key when connecting to EC2
  ssh_pubkey = file("id_rsa.pub")
  # CIDR allowed to SSH into the deployed EC2
  ssh_sources = ["0.0.0.0/0"]
  # CIDR for the egress rule of the EC2
  external_traffic_cidrs = ["0.0.0.0/0"]
  # CIDR allowed to reach the web layer
  ingress_traffic_cidrs = ["0.0.0.0/0"]

  # USE PRIVATE ADDRESSES TO AVOID THE EXPOSURE OF THE APPLICATION AND THE DATA LAYER
  db_allowed_cidr           = [module.network.vpc.cidr_block]
  application_allowed_cidrs = [module.network.vpc.cidr_block]

  tags = local.tags
}