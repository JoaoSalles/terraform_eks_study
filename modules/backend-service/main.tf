resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"     # Name the service
  cluster         = "${var.aws_ecs_cluster_id}"   # Reference the created Cluster
  task_definition = "${aws_ecs_task_definition.backend_task.arn}" # Reference the task that the service will spin up
  launch_type     = "FARGATE"
  desired_count   = 1 # Set up the number of containers to 3

  load_balancer {
    target_group_arn = var.lb_target_group_arn # Reference the target group
    container_name   = "${aws_ecs_task_definition.backend_task.family}"
    container_port   = 5000 # Specify the container port
  }

  network_configuration {
    subnets          = var.subnet_ids # Specify the subnets
    assign_public_ip = false     # Provide the containers with public IPs
    security_groups  = [
      "${aws_security_group.service_security_group.id}",
      "${var.lb_sg_id}"
    ] # Set up the security group
  }
}