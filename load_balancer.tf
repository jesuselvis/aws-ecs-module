resource "aws_lb" "my_load_balancer" {
  name               = "my-lb"
  internal           = true #true (lb = subnet_private ) || false (lb=subnet_public)
  load_balancer_type = "application"
  subnets            = var.subnet_ecs_services
  security_groups    = [aws_security_group.ecs_service_sg.id]
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "my-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    port = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}
