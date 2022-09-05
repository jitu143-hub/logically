terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc/vpc/terraform.tfstate"
  }
}

module "geotrade-app-org-subnets" {
  source       = "/Users/pavanwadhe/Downloads/work/Mouritech Work/iac-geotrade-application/terraform-modules/subnets"
  project_id   = var.project_id
  network_name = data.terraform_remote_state.vpc.outputs.network_name

subnets = [
    {
      subnet_name               = "${var.project_name}-org-db-subnet-${var.env_name}"
      subnet_ip                 = "${var.app_org_subnet_db_ip}"
      subnet_region             = var.gcp_region
      subnet_private_access     = "true"
    }
  ]
}