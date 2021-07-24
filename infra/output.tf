output "instances" {
  description = "The deployed servers"
  value       = aws_instance.default
}

output "load_balancer" {
  description = "The deployed load balancer"
  value       = aws_lb.default
}

output "load_balancer_listener" {
  description = "The load balancer listener"
  value       = aws_lb_listener.default
}

output "target_group" {
  description = "The target group"
  value       = aws_lb_target_group.default
}

output "security_group" {
  description = "The security group of the servers"
  value       = aws_security_group.default
}

output "ssh_key" {
  description = "The ssh key imported to AWS"
  value       = aws_security_group.default
}