resource "aws_ecs_task_definition" "backend_task" {
  family                   = "${var.prefix}-backend-task" # Name your task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.prefix}-backend-task",
      "image": "docker.io/jaosalless/node-base-ec2-private:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 5000,
          "hostPort": 5000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # use Fargate as the launch type
  network_mode             = "awsvpc"    # add the AWS VPN network mode as this is required for Fargate
  memory                   = 512         # Specify the memory the container requires
  cpu                      = 256         # Specify the CPU the container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}
