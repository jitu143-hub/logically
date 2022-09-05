terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc-dev-new/vpc/terraform.tfstate"
  }
}



module "postgres" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
   source = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-application/terraform-modules/cloud-sql"
  #source = "./modules/cloud-sql"

  project = var.project_id
  region  = var.gcp_region
  name    = var.dev_db_instance_name
  db_name = var.dev_db_name

  engine       = var.dev_db_postgres_version
  machine_type = var.dev_db_machine_type

  # These together will construct the master_user privileges, i.e.
  # 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'.
  # These should typically be set as the environment variable TF_VAR_master_user_password, etc.
  # so you don't check these into source control."
  master_user_password = var.dev_db_master_user_password

  master_user_name = var.dev_db_master_user_name
  master_user_host = "%"

  # Pass the private network link to the module
  private_network = data.terraform_remote_state.vpc.outputs.network_self_link

  # Wait for the vpc connection to complete
  # dependencies = [google_service_networking_connection.private_vpc_connection.network]

  custom_labels = {
    env_name = "${var.env_name}"
  }
}
