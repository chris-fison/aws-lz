# # provider "aws" {
# #   region = "us-east-1"  # Replace with your desired AWS region
# # }

# # Create a simple HTML file
# data "aws_ami" "latest_amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
# }

# resource "aws_s3_bucket_object" "html" {
#   bucket = "fisontech-hellow-world"
#   key    = "index.html"
#   acl    = "public-read"

#   source = <<-EOT
#     <!DOCTYPE html>
#     <html>
#     <head>
#       <title>Hello, World!</title>
#     </head>
#     <body>
#       <h1>Hello, World!</h1>
#     </body>
#     </html>
#   EOT
# }

# # Create ECS task definition
# resource "aws_ecs_task_definition" "hello_world" {
#   family                   = "hello-world"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]

#   container_definitions = jsonencode([
#     {
#       name  = "hello-world-container"
#       image = "nginx:latest"
#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#         },
#       ],
#       essential = true,
#     },
#   ])
# }

# # Create ECS Fargate service
# resource "aws_ecs_service" "hello_world_service" {
#   name            = "hello-world-service"
#   cluster         = "default"  # Replace with your ECS cluster name
#   task_definition = aws_ecs_task_definition.hello_world.arn
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]  # Replace with your subnet IDs
#     security_groups = ["sg-xxxxxxxxxxxxxxxxx"]  # Replace with your security group ID
#   }

#   depends_on = [aws_ecs_task_definition.hello_world]
# }

# output "website_url" {
#   value = aws_ecs_service.hello_world_service.load_balancer[0].dns_name
# }
