locals {
  aws_region = "ap-southeast-2"
}

terraform {
  # Deploy version v0.0.3 in stage
  source = "git::git@github.com:LanceXuanLi/searchingJob.git//terraform/backend_moudle?ref=master"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)