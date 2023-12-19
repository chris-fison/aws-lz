terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
       # Replace this with your bucket name!
      bucket = "aws-lz-tfstate-s3"
      key = "global/s3/terraform.tfstate"
      region= "eu-west-2"
      # Replace this with your DynamoDB table name!
      dynamodb_table = "aws-lz-tfstate-cdb"
      encrypt        = true
     }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name
  force_destroy = true
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}