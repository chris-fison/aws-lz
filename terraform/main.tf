provider "aws" {
  region = "eu-west-2"  # Specify your desired AWS region
}

# resource "aws_instance" "example" {
#   ami           = "ami-093cb9fb2d34920ad"  # Specify the AMI ID for your desired operating system
#   instance_type = "t2.micro"  # Specify the instance type

#   tags = {
#     Name = "example-instance"
#   }
# }
