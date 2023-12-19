resource "aws_instance" "test" {
  ami           = "ami-093cb9fb2d34920ad"
  instance_type = "t2.micro"
}