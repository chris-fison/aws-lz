provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "aws-lz-tfstate-s3"
    key    = "state/terraform-state.tf"
    region = "eu-west-2"
  }
}


# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
# }