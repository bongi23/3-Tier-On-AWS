############## Common ########################
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for all the Network resources"
}
##############################################
############## VPC variables ##################
variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "vpc_enable_dns_hostname" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
}

variable "vpc_enable_dns_support" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC"
}

variable "vpc_name" {
  type        = string
  default     = "SatispayAssessment"
  description = "Name tag for the VPC."
}

#################################################
############### Subnets variables ###############
variable "availability_zones" {
  type        = list(string)
  description = "AZs where to deploy the subnets"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for the public subnets"
}

variable "data_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for the data subnets"
}

variable "application_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for the application subnets"
}