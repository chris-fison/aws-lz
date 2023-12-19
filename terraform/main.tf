terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  backend "s3" {
    bucket         	   = "aws-lz-tfstate-s3"
    key              	 = "state/terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    dynamodb_table     = "aws-lz-tfstate-cdb"
  }
}

# Define the EC2 instance
resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Change this to the desired AMI ID
  instance_type = "t2.micro"               # Change this to the desired instance type

  tags = {
    Name = "example-instance"
  }
}
