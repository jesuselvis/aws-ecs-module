#------- vpc----
variable "vpc_id" {
  description = "ip de la vpc"
  type = string
  default = "vpc-0858703b6e56cc25a"
}
# variable "ecr_image" {
#   description = "imagen a desplegar"
#   type = string
#   default = "323255643294.dkr.ecr.us-east-1.amazonaws.com/test/image"
# }

#---------ecs----------
variable "ecs_cluster_name" {
  description = "nombre del cluster ecs"
  type = string
  default = "my-cluster-ecs"
}
#-------task definition ------
variable "family" {
  description = "nombre de la tarea familia"
  type = string
  default = "task-def-demo"
}
variable "network_mode" {
  description = "tipo de conexcion"
  type = string
  default = "awsvpc"
}
variable "cpu" {
  description = "cantidad de cpu"
  type = string
  default = "1024"
}
variable "memory" {
  description = "cantidad de memoria"
  type = string
  default = "2048"
}
variable "requires_compatibilities" {
  description = "tipo de compatibilidad"
  type = list(string)
  default = [ "FARGATE" ]
}

#------ cluster service ---------
variable "ecs_service_name" {
  description = "nombre del servicio"
  type = string
  default = "my-service-cluster"
}
variable "desired_count" {
  description = "numero de instancias deseadas"
  type = number
  default = 1
}
variable "launch_type" {
  description = "puede ser instancias ec2 o fargate"
  type = string
  default = "FARGATE"
}
variable "subnet_ecs_services" {
  description = "subnets para el servicio de ECS"
  type = list(string)
  default = [ "subnet-0adb5961b4cfffcd0","subnet-087b34b84ad3a9fc4" ]
}
# variable "security_groups_services" {
#   description = "grupo de seguridad para el servicio"
#   type = list(string)
#   default = [ "value" ]
# }
# variable "target_group_arn" {
#   description = "arn del target group"
#   type = string

# }
variable "container_name" {
  description = "nombre del contenedor"
  type = string
  default = "container-demo"
}
variable "container_port" {
  description = "puerto del contenedor"
  type = number
  default = 80
}