resource "random_integer" "server" {
  min = 1
  max = 10000
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    listener_arn = var.ami_id
  }
}

resource "aws_s3_bucket" "backend" {
  bucket = "${var.backend_bucket}-${random_integer.server.id}"
  object_lock_enabled = true
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "backend" {
  name           = "${var.lock_table}-${random_integer.server.id}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}

resource "aws_iam_policy" "bucket_backend" {
  name        = "${aws_s3_bucket.backend.id}-backend-${random_integer.server.id}"
  path        = "/"
  description = "${aws_s3_bucket.backend.id}_backend_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.backend.id}"
      },
      {
        "Effect": "Allow",
        "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        "Resource": "arn:aws:s3:::${aws_s3_bucket.backend.id}/tf_state"
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_backend" {
  name        = "${aws_dynamodb_table.backend.id}-dynamodb-backend-${random_integer.server.id}"
  path        = "/"
  description = "${aws_s3_bucket.backend.id}_backend_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ],
        "Resource": "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.backend.id}"
      }
    ]
  })
}