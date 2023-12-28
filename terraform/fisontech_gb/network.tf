# Adding new VPC
resource "aws_vpc" "fisontech_pgb" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Fisontech-VPC-gb"
  }
}
