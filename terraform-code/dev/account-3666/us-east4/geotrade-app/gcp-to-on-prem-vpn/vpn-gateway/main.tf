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

resource "google_compute_ha_vpn_gateway" "gcp-onprem-ha_gateway" {
    region = var.gcp_region
    name = "${var.project_id}-gcp-onprem-ha-gateway"
    network = data.terraform_remote_state.vpc.outputs.network_self_link
}
