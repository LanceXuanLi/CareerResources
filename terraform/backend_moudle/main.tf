terraform {
  backend "s3" {
    bucket         = var.backend_bucket
    key            = var.backend_key
    region         = var.backend_region
    encrypt        = true
    dynamodb_table = var.lock_table
  }
}