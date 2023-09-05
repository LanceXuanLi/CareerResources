variable "backend_bucket" {
  description = "Name of the S3 bucket to use as the backend"
  type        = string
}

variable "lock_table" {
  description = "Name of the DynamoDB table used for state locking"
  type        = string
}