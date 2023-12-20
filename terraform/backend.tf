terraform {
  backend "s3" {
    bucket         = "fisontech-tfstate"
    key            = "state/key"
    region         = "eu-west-2"
    dynamodb_table = "fisontech-tfstate"
  }
}