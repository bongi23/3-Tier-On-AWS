# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostname
  enable_dns_support   = var.vpc_enable_dns_support
  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}