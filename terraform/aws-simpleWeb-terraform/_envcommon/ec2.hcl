
terraform {
  source = "${local.base_source_url}?ref=master"

}


locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  envName = local.env_vars.locals.environment
  base_source_url = "git::git@github.com:LanceXuanLi/searchingJob.git//terraform/aws-simpleWeb-terraform/module"
}

inputs = {
  ec2-name = "my-hello-world-${local.envName}"
  ec2-tag= "hello"
}