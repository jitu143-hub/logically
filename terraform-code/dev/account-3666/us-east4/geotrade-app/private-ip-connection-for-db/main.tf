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


resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc-nqarm"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = data.terraform_remote_state.vpc.outputs.network_name
  address       = "10.71.247.0"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.terraform_remote_state.vpc.outputs.network_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}
