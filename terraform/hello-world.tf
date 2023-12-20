# # provider "aws" {
# #   region = "us-east-1"  # Specify your desired AWS region
# # }

# # Create VPC, Subnet, and Security Group
# resource "aws_vpc" "example_vpc" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "example_subnet" {
#   vpc_id     = aws_vpc.example_vpc.id
#   cidr_block = "10.0.1.0/24"
# }

# resource "aws_security_group" "example_security_group" {
#   vpc_id = aws_vpc.example_vpc.id
#   // You may need to adjust these ingress rules based on your specific needs
#   ingress {
#     from_port = 80
#     to_port   = 80
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # Create ECS Task Definition
# resource "aws_ecs_task_definition" "example_task" {
#   family                   = "example-task"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]

#   container_definitions = jsonencode([
#     {
#       name  = "example-container"
#       image = "nginx:latest"  # Replace with your Docker image URL

#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#         },
#       ]
#     },
#   ])
# }

# # Create ECS Service
# resource "aws_ecs_service" "example_service" {
#   name            = "example-service"
#   cluster         = "default"  # Replace with your ECS cluster name
#   task_definition = aws_ecs_task_definition.example_task.arn

#   launch_type = "FARGATE"

#   network_configuration {
#     subnets = [aws_subnet.example_subnet.id]
#     security_groups = [aws_security_group.example_security_group.id]
#   }

#   depends_on = [aws_ecs_task_definition.example_task]
# }
