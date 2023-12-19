provider "aws" {
  region  = "eu-west-2"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

 backend "s3" {
    bucket         	   = "aws-lz-tfstate-s3"
    key                = "state/terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    dynamodb_table = "aws-lz-tfstate-cdb"
  }
}