locals  {
  backend_region = "ap-southeast-2"
  backend_bucket = "backendtest0905-6116"
  dynamodb_name = "backendtest0905-6116"
}
terraform {
  # Deploy version v0.0.3 in stage
  source = "git::git@github.com:LanceXuanLi/searchingJob.git//terraform/aws-simpleWeb-terraform/module?ref=master"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.backend_bucket}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.backend_region}"
    encrypt        = true
    dynamodb_table = "${local.dynamodb_name}"
  }
}
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.backend_region}"
}
EOF
}

inputs = {
  ec2-name = "helloworldtest"
}