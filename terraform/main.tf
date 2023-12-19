resource "aws_instance" "demo" {
  ami                 = var.ami
  instance_type = var.type

  tags = {
    name = "My VM"
  }
}