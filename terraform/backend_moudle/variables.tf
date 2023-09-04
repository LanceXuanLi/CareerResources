variable "backend_bucket" {
  description = "Name of the S3 bucket to use as the backend"
  type        = string
}

variable "backend_key" {
  description = "The path in the S3 bucket to store Terraform state"
  type        = string
}

variable "backend_region" {
  description = "AWS region where the S3 bucket and DynamoDB table are located"
  type        = string
}

variable "lock_table" {
  description = "Name of the DynamoDB table used for state locking"
  type        = string
}