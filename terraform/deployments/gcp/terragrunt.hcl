locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region   = local.region_vars.locals.region
}

remote_state {
  backend = "gcs"
  config = {
    bucket         = "ifr-tfstate-${local.region}"
    prefix         = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
