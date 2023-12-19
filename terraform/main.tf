provider "aws" {
  region = "eu-west-2"
}
resource "aws_s3_bucket" "example" {
  bucket = "my-fisontech-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}