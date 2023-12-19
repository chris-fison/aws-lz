# Define the provider (AWS in this case)
provider "aws" {
  region = "eu-west-2"  # Change this to your preferred AWS region
}

# Define the Security Group
resource "aws_security_group" "example_security_group" {
  name        = "example-security-group"
  description = "Example Security Group for EC2 instances"

  ingress {
    from_port   = 22  # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP address
  }

  # Add more ingress rules as needed
}