# module "vpc" {
#   source = "https://github.com/terraform-aws-modules/terraform-aws-vpc"

#   name                 = "my-vpc"
#   cidr                 = "10.0.0.0/16"
#   azs                  = ["eu-west-2a", "eu-west-2b"]
#   private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
#   public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
#   enable_nat_gateway   = true
#   single_nat_gateway   = true
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags                 = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

# # Adding new VPC
# resource "aws_vpc" "fisontech_ws_0" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "Fisontech-VPC-ws-0"
#   }
# }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "my-vpc-ws"
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}