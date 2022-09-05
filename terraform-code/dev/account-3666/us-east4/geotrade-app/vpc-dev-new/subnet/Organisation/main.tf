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

module "geotrade-central-app-subnet" {
  source       = "/Users/pavanwadhe/Downloads/work/Mouritech Work/iac-geotrade-application/terraform-modules/subnets"
  project_id   = var.project_id # Replace this with your project ID in quotes
  network_name = data.terraform_remote_state.vpc.outputs.network_id

subnets = [
    {
      subnet_name   = "${var.project_name}-organisation-subnet-${var.env_name}"
      subnet_ip     = var.org_subnet_private_ip
      subnet_region = var.gcp_region
      subnet_private_access = "true"
    }
  ]
  secondary_ranges = {
        "${var.project_name}-organisation-subnet-${var.env_name}" = [
            {
                range_name    = "${var.project_name}-organisation-ip-range-pods-${var.env_name}"
                ip_cidr_range = var.org_subnet_range_pod_ip
            },
            {
                range_name    = "${var.project_name}-organisation-ip-range-services-${var.env_name}"
                ip_cidr_range = var.org_subnet_range_service_ip
            }
        ]
  }
  
} 
