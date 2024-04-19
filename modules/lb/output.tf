output "app_url" {
  value = aws_lb.application_load_balancer.dns_name
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "lb_sg_id" {
  value = aws_security_group.load_balancer_security_group.id
}