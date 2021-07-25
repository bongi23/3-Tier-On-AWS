output "vpc" {
  description = "VPC data"
  value       = aws_vpc.default
}

output "public_subnets" {
  description = "Public subnets data"
  value       = aws_subnet.default
}

output "internet_gw" {
  description = "Internet Gateway data"
  value       = aws_internet_gateway.default
}

output "public_subnet_rt" {
  description = "Public subnet route table data"
  value       = aws_route_table.public_rt
}
