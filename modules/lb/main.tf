resource "aws_lb" "application_load_balancer" {
  name               = "${var.prefix}-load-balancer" #load balancer name
  load_balancer_type = "application"
  subnets = var.subnet_ids
  # security group
  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic in from all sources
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// public
resource "aws_lb_target_group" "target_group" {
  name        = "${var.prefix}-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.application_load_balancer.arn}" #  load balancer
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}" # target group
  }
}

// private
resource "aws_lb_target_group" "target_group_private" {
  name     = "tg-b"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = "${var.vpc_id}"

  health_check {
    path = "/"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener_rule" "service_b_rule" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_private.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }

  condition {
     source_ip {
      values = [var.vpc_ip]
    }
  }
}