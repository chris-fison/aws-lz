terraform {
  backend "s3" {
    bucket         = "fisontech-tfstate"
    key            = "state/fisontech-ws"
    region         = "eu-west-2"
    dynamodb_table = "fisontech-tfstate"
  }
}