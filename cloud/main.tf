module "network" {
  source = "./network"
  vpc_name = "Satispay"
  public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  application_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  data_subnet_cidrs = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_cidr_block = "10.0.0.0/18"
}