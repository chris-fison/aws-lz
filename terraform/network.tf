resource "aws_vpc" "fisontech_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Fisontech-VPC"
  }
}


# Adding new VPC
resource "aws_vpc" "fisontech_vpc3" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Fisontech-VPC3"
  }
}


# Adding new VPC
resource "aws_vpc" "fisontech_vpc4" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Fisontech-VPC4"
  }
}

