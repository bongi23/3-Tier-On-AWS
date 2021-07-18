output "vpc" {
  description = "VPC data"
  value       = aws_vpc.default
}

output "public_subnets" {
  description = "Public subnets data"
  value       = aws_subnet.public
}

output "application_subnets" {
  description = "Application subnets data"
  value       = aws_subnet.application
}

output "data_subnets" {
  description = "Data subnets data"
  value       = aws_subnet.data
}

output "internet_gw" {
  description = "Internet Gateway data"
  value       = aws_internet_gateway.default
}

output "nat_gw" {
  description = "NAT Gateway data"
  value       = aws_nat_gateway.default
}

output "nat_eip" {
  description = "NAT's elastic IP data"
  value       = aws_eip.natgw_eip
}

output "public_subnet_rt" {
  description = "Public subnet route table data"
  value       = aws_route_table.public_rt
}

output "application_subnet_rt" {
  description = "Public subnet route table data"
  value       = aws_route_table.application_rt
}

output "data_subnet_rt" {
  description = "Public subnet route table data"
  value       = aws_route_table.data_rt
}