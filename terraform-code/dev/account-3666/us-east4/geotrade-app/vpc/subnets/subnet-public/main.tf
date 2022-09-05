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

module "geotrade-app-subnets" {
  source       = "/Users/pavanwadhe/Downloads/work/Mouritech Work/iac-geotrade-application/terraform-modules/subnets"
  project_id   = var.project_id # Replace this with your project ID in quotes
  network_name = data.terraform_remote_state.vpc.outputs.network_name

  subnets = [
    {
      subnet_name           = "${var.project_name}-public-subnet-${var.env_name}"
      subnet_ip             = "${var.app_subnet_public_ip}"
      subnet_region         = var.gcp_region
    }
  ]
}