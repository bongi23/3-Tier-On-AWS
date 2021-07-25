module "network" {
  source                   = "./network"
  vpc_name                 = "Satispay"
  public_subnet_cidrs      = ["10.0.0.0/24"]#, "10.0.1.0/24", "10.0.2.0/24"]
  application_subnet_cidrs = []#"10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  data_subnet_cidrs        = []#"10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
  availability_zones       = ["eu-central-1a"]#, "eu-central-1b", "eu-central-1c"]
  vpc_cidr_block           = "10.0.0.0/18"
}

//module "infra" {
//  source = "./infra"
//  vpc_id = module.network.vpc.id
//
//  # Subnets IDs
//  public_subnets = [for subnet in module.network.public_subnets: subnet.id]
//  application_subnets = [for subnet in module.network.application_subnets: subnet.id]
//  data_subnets = [for subnet in module.network.data_subnets: subnet.id]
//
//  #Subnets CIDRs
//  public_subnets_cidr = [for subnet in module.network.public_subnets: subnet.cidr_block]
//  application_subnets_cidr = [for subnet in module.network.public_subnets: subnet.cidr_block]
//  data_subnets_cidr = [for subnet in module.network.data_subnets: subnet.cidr_block]
//
//  ssh_sources = ["0.0.0.0/0"]
//
//  tags = {Project = "Satispay"}
//}