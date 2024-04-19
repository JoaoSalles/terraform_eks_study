resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.prefix}-task" # Name your task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.prefix}-task",
      "image": "docker.io/jaosalless/basic-node-ec2:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
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