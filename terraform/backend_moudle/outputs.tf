output "backend_bucket_name" {
  description = "Name of the S3 bucket used as the backend"
  value       = aws_s3_bucket.backend.id
}

output "backend_dynamodb_name" {
  description = "Name of the S3 dynamodb used as the backend state lock"
  value       = aws_dynamodb_table.backend.id
}