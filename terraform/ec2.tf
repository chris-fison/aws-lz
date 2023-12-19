# Define the provider (AWS in this case)
provider "aws" {
  region = "eu-west-2"  # Change this to your preferred AWS region
}

# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create a public subnet
resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-2"  # Change this to your preferred availability zone
  map_public_ip_on_launch = true
}

# Create an internet gateway
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}

# Attach the internet gateway to the VPC
resource "aws_vpc_attachment" "example_igw_attachment" {
  vpc_id             = aws_vpc.example_vpc.id
  internet_gateway_id = aws_internet_gateway.example_igw.id
}

# Create a route table
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "example_subnet_association" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}

# Create an EC2 instance
resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Change this to the desired AMI ID
  instance_type = "t2.micro"               # Change this to the desired instance type
  subnet_id     = aws_subnet.example_subnet.id

  tags = {
    Name = "example-instance"
  }
}

