provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
# }


# # main.tf

# provider "aws" {
#   region = "eu-west-2" # Set your desired AWS region
# }

# # Create a VPC
# resource "aws_vpc" "example_vpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_support = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "example-vpc"
#   }
# }

# # Create a subnet within the VPC
# resource "aws_subnet" "example_subnet" {
#   vpc_id                  = aws_vpc.example_vpc.id
#   cidr_block              = "10.0.0.0/24"
#   availability_zone       = "eu-west-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "example-subnet"
#   }
# }

# # Create an Internet Gateway for the VPC
# resource "aws_internet_gateway" "example_igw" {
#   vpc_id = aws_vpc.example_vpc.id

#   tags = {
#     Name = "example-igw"
#   }
# }

# # Create a route table and associate it with the subnet
# resource "aws_route_table" "example_route_table" {
#   vpc_id = aws_vpc.example_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.example_igw.id
#   }

#   tags = {
#     Name = "example-route-table"
#   }
# }

# resource "aws_route_table_association" "example_subnet_association" {
#   subnet_id      = aws_subnet.example_subnet.id
#   route_table_id = aws_route_table.example_route_table.id
# }

# # Create a security group for the EC2 instance
# resource "aws_security_group" "example_security_group" {
#   vpc_id = aws_vpc.example_vpc.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "example-security-group"
#   }
# }

# # Create an EC2 instance within the subnet
# resource "aws_instance" "example_instance" {
#   ami           = "ami-093cb9fb2d34920ad" # Replace with your desired AMI ID
#   instance_type = "t2.micro"
#   key_name      = "aws-ec2"         # Replace with your key pair name
#   subnet_id     = aws_subnet.example_subnet.id

#   vpc_security_group_ids = [aws_security_group.example_security_group.id]

#   tags = {
#     Name = "example-instance"
#   }
# }
