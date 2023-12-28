module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name                 = "my-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["eu-west-2a", "eu-west-2b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  public_subnet_tags   = { "Tier" = "Public" }
  private_subnet_tags  = { "Tier" = "Private" }
}

output "vpc_id" {
  value = module.my_vpc.vpc_id
}