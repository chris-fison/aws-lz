module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "fisontech_ws"
  cidr = "10.10.0.0/16"
  azs             = ["eu-west-2a", "eu-west-2b"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.3.0/24", "10.10.4.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "fisontech_ws"
    Environment = "Production"
  }
}