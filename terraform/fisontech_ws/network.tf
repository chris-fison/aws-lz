module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "fisontech-ws"
  cidr = "10.10.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.3.0/24", "10.10.4.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "fisontech-ws"
    Environment = "Production"
  }
}


resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = aws_directory_service_directory.aws-managed-ad.dns_ip_addresses
  domain_name = "fisontech-ws.local"
  tags = {
    Name = "fisontech-ws-prod-dhcp-option"
    Environment = "Production"
  }
}
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id = module.vpc.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}