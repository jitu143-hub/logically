terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc/vpc-new/terraform.tfstate"
  }
}

resource "google_compute_router" "geotrade-app-nat-router" {
  project = var.project_id
  name    = "geotrade-app-nat-router"
  network = data.terraform_remote_state.vpc.outputs.network_name
  region  = var.gcp_region
}

module "geotrade-app-cloud-nat" {
  source                             = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-application/terraform-modules/google-cloud-nat"
  project_id                         = var.project_id
  region                             = var.gcp_region
  router                             = google_compute_router.geotrade-app-nat-router.name
  name                               = "geotrade-app-nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}