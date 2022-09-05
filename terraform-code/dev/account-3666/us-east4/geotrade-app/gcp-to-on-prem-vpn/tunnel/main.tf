terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "vpn-gateway" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/gcp-to-on-prem-vpn/vpn-gateway/terraform.tfstate"
  }
}

data "terraform_remote_state" "external-gateway" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/gcp-to-on-prem-vpn/external-gateway/terraform.tfstate"
  }
}

data "terraform_remote_state" "cloud-router" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/gcp-to-on-prem-vpn/cloud-router/terraform.tfstate"
  }
}

#Create VPN Tunnel 1
resource "google_compute_vpn_tunnel" "vpn-tunnel1-gcp-onprem" {
  name                            = "${var.project_id}-vpn-tunnel1-gcp-onprem"
  project                         = var.project_id
  region                          = var.gcp_region
  vpn_gateway                     = data.terraform_remote_state.vpn-gateway.outputs.id
  peer_external_gateway           = data.terraform_remote_state.external-gateway.outputs.id
  peer_external_gateway_interface = 0
  shared_secret                   = var.gcp_onprem_shared_secret_t1
  router                          = data.terraform_remote_state.cloud-router.outputs.id
  vpn_gateway_interface           = 0
}

# #Create VPN Tunnel 2
resource "google_compute_vpn_tunnel" "vpn-tunnel2-gcp-onprem" {
  name                            = "${var.project_id}-vpn-tunnel2-gcp-onprem"
  project                         = var.project_id
  region                          = var.gcp_region
  vpn_gateway                     = data.terraform_remote_state.vpn-gateway.outputs.id
  peer_external_gateway           = data.terraform_remote_state.external-gateway.outputs.id
  peer_external_gateway_interface = 1
  shared_secret                   = var.gcp_onprem_shared_secret_t2
  router                          = data.terraform_remote_state.cloud-router.outputs.id
  vpn_gateway_interface           = 1
}
