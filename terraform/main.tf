terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

 backend "s3" {
    bucket         	   = "aws-lz-tfstate-s3"
    key                = "state/terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    dynamodb_table     = "aws-lz-tfstate-cdb"
  }
}
# resource "aws_instance" "example" {
#   ami           = "ami-093cb9fb2d34920ad"  # Specify the AMI ID for your desired operating system
#   instance_type = "t2.micro"  # Specify the instance type

#   tags = {
#     Name = "example-instance"
#   }
# }
