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

module "geotrade-app-central-subnets-new" {
  source       = "/Users/pavanwadhe/Downloads/work/Mouritech Work/iac-geotrade-application/terraform-modules/subnets"
  project_id   = var.project_id # Replace this with your project ID in quotes
  network_name = data.terraform_remote_state.vpc.outputs.network_name

subnets = [
    {
      subnet_name   = "${var.project_name}-central-services-subnet-${var.env_name}-new"
      subnet_ip     = "10.71.248.0/24"
      subnet_region = var.gcp_region
      subnet_private_access = "true"
    }
  ]
  secondary_ranges = {
        "${var.project_name}-central-services-subnet-${var.env_name}-new" = [
            {
                range_name    = "${var.project_name}-central-services-ip-range-pods-${var.env_name}-staging"
                ip_cidr_range = "10.71.252.0/22"
            },
            {
                range_name    = "${var.project_name}-central-services-ip-range-services-${var.env_name}-staging"
                ip_cidr_range = "10.71.250.0/23"
            }
        ]
  }
  
} 
