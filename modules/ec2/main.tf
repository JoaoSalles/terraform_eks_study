resource "aws_ecs_cluster" "new-cluster" {
  name = "${var.prefix}-cluster"
}

resource "aws_ecs_service" "app_service" {
  name            = "app-first-service"     # Name the service
  cluster         = "${aws_ecs_cluster.new-cluster.id}"   # Reference the created Cluster
  task_definition = "${aws_ecs_task_definition.app_task.arn}" # Reference the task that the service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Set up the number of containers to 3

  load_balancer {
    target_group_arn = var.lb_target_group_arn # Reference the target group
    container_name   = "${aws_ecs_task_definition.app_task.family}"
    container_port   = 3000 # Specify the container port
  }

  network_configuration {
    subnets          = var.subnet_ids # Specify the subnets
    assign_public_ip = true     # Provide the containers with public IPs
    security_groups  = ["${aws_security_group.service_security_group.id}"] # Set up the security group
  }
}