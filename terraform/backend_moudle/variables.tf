variable "backend_bucket" {
  description = "Name of the S3 bucket to use as the backend"
  type        = string
  default = "test-1"
}

variable "lock_table" {
  description = "Name of the DynamoDB table used for state locking"
  type        = string
  default = "test-1"
}

variable "ami_id" {
  description = "Seeds of Random function"
  type = string
  default = "05092023"
}