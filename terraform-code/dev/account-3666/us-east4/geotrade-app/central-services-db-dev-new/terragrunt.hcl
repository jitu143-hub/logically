locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.environment_vars.locals.environment

  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  domain = local.project_vars.locals.domain_name
  project_name = local.project_vars.locals.project_name
  dev_db_name = local.project_vars.locals.dev_db_name
  dev_db_instance_name = local.project_vars.locals.dev_db_instance_name
  dev_db_master_user_name = local.project_vars.locals.dev_db_master_user_name
  dev_db_master_user_password = local.project_vars.locals.dev_db_master_user_password
  dev_db_machine_type = local.project_vars.locals.dev_db_machine_type
  dev_db_postgres_version = local.project_vars.locals.dev_db_postgres_version
  #subject_alternative_names = local.domain_vars.locals.subject_alternative_names

  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  local_dir = local.account_vars.locals.local_dir
  gcp_account_id = local.account_vars.locals.gcp_account_id

  gcp_account_short_id = local.account_vars.locals.gcp_account_short_id

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  gcp_region = local.region_vars.locals.gcp_region
  gcp_region_short_id = local.region_vars.locals.gcp_region_short_id
  project_id = local.project_vars.locals.project_id
 

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")
}

terraform {
  source = "${path_relative_from_include()}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    env_name = local.env_name
    local_dir = local.local_dir
    gcp_region = local.gcp_region
    gcp_account_id = local.gcp_account_id
    domain_name = local.domain_name
    gcp_account_short_id = local.gcp_account_short_id
    project_name = local.project_name
    project_id = local.project_id
    gcp_region_short_id = local.gcp_region_short_id
    dev_db_name = local.dev_db_name
    dev_db_instance_name = local.dev_db_instance_name
    dev_db_master_user_name = local.dev_db_master_user_name
    dev_db_master_user_password = local.dev_db_master_user_password
    dev_db_machine_type = local.dev_db_machine_type
    dev_db_postgres_version = local.dev_db_postgres_version
}
