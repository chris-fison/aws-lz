terraform {
  backend "s3" {
    encrypt = true    
    bucket = "hella-buckets"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}