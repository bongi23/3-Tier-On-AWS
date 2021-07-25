############## Common ########################
variable "availability_zones" {
  type        = list(string)
  description = "AZs where to deploy the network"
}

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
  description = "Name tag for the VPC."
}

#################################################
############### Subnets variables ###############
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for the public subnets"
}