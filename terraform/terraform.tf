provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-093cb9fb2d34920ad"
  instance_type = "t2.micro"
}