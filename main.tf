resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family = var.family
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_role.arn

  requires_compatibilities = var.requires_compatibilities
  container_definitions = jsonencode([{
    name= "container-demo"
    image= "nginx:latest"
    essential = true
    cpu = 256
    memory = 512

    "portMappings" = [{
        "containerPort" = 80
        "hostPort" = 80 # Esto permite asignar puertos dinámicos si usas ALB.
    }]
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name = var.ecs_service_name
  cluster = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count = var.desired_count
  launch_type = var.launch_type

  network_configuration {
    subnets = var.subnet_ecs_services
    security_groups = [aws_security_group.ecs_service_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name = var.container_name  # Asegúrate de que coincide con el task definition.
    container_port = var.container_port
  }
  depends_on = [ aws_lb_listener.my_listener ]

}
