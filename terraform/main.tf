provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    # encrypt = true
    bucket = "aws-lz-tfstate-s3"
    dynamodb_table = "aws-lz-tfstate-cdb"
    key    = "state/terraform-state.tf"
    region = "eu-west-2"
  }
}


# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
# }