# provider "aws" {
#   region = "us-east-1"  # Replace with your desired AWS region
# }

# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create an internet gateway
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}

# Create a route table for public subnets
resource "aws_route_table" "example_public_rt" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

# Create a subnet for HTTP traffic
resource "aws_subnet" "example_http_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.1.0/24"  # Replace with your desired subnet CIDR block
  availability_zone       = "eu-west-2"  # Replace with your desired availability zone
  map_public_ip_on_launch = true
#   route_table_association {
#     subnet_id      = aws_subnet.example_http_subnet.id
#     route_table_id = aws_route_table.example_public_rt.id
#   }
}

# Create a security group for HTTP
resource "aws_security_group" "example_http_sg" {
  name        = "example-http-sg"
  description = "Security group for HTTP traffic"

  vpc_id = aws_vpc.example_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this to restrict the source IP range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
