output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "arn:aws:s3:::aws-lz-tfstate-s3"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "arn:aws:dynamodb:eu-west-2:506331098100:table/aws-lz-tfstate-cdb"
}