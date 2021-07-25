output "network" {
  value = module.network
}

output "infra" {
  value = module.infra
}

output "lb_dns_name" {
  value = module.infra.load_balancer.dns_name
}