output "aws_ecs_cluster_id" {
    value = aws_ecs_cluster.new-cluster.id
}

output "sg_public_id" {
    value = aws_security_group.service_security_group.id
}