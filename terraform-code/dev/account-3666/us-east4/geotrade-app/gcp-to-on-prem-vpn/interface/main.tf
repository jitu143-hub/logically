terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "cloud-router" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/gcp-to-on-prem-vpn/cloud-router/terraform.tfstate"
  }
}

data "terraform_remote_state" "tunnel" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/gcp-to-on-prem-vpn/tunnel/terraform.tfstate"
  }
}


# # Create Cloud Router Interface 1
resource "google_compute_router_interface" "vpn-router-interface1-gcp-onprem" {
  name       = "${var.project_id}-cloud-router-interface1-gcp-onprem"
  project    = var.project_id
  router     = data.terraform_remote_state.cloud-router.outputs.name
  region     = var.gcp_region
  ip_range   = "169.254.0.1/30"
  vpn_tunnel = data.terraform_remote_state.tunnel.outputs.tunnel_1_id
}

#Create Cloud Router Interface 2
resource "google_compute_router_interface" "vpn-router-interface2-gcp-onprem" {
  name       = "${var.project_id}-cloud-router-interface2-gcp-onprem"
  project    = var.project_id
  router     = data.terraform_remote_state.cloud-router.outputs.name
  region     = var.gcp_region
  ip_range   = "169.254.0.5/30"
  vpn_tunnel = data.terraform_remote_state.tunnel.outputs.tunnel_2_id
}
