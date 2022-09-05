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

data "terraform_remote_state" "interface" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/gcp-to-on-prem-vpn/interface/terraform.tfstate"
  }
}

# Create Cloud Router Peer 1
resource "google_compute_router_peer" "vpn-router-peer1-gcp-onprem" {
  name                      = "${var.project_id}-cloud-router-peer1-gcp-onprem"
  project                   = var.project_id
  router                    = data.terraform_remote_state.cloud-router.outputs.name
  region                    = var.gcp_region
  peer_ip_address           = var.gcp_onprem_router_peer1_ip_address
  peer_asn                  = var.peer_asn
  advertised_route_priority = 100
  interface                 = data.terraform_remote_state.interface.outputs.interface_1_name
  advertise_mode            = "CUSTOM"
  advertised_ip_ranges {
      range = "10.71.248.0/21"
    }
  advertised_ip_ranges {
      range = "10.71.247.0/24"
    }

  advertised_ip_ranges {
      range = "10.71.239.64/26"
    }
    
}

# Create Cloud Router Peer 2
resource "google_compute_router_peer" "vpn-router-peer2-gcp-onprem" {
  name                      = "${var.project_id}-cloud-router-peer2-gcp-onprem"
  project                   = var.project_id
  router                    = data.terraform_remote_state.cloud-router.outputs.name
  region                    = var.gcp_region
  peer_ip_address           = var.gcp_onprem_router_peer2_ip_address
  peer_asn                  = var.peer_asn
  advertised_route_priority = 100
  interface                 = data.terraform_remote_state.interface.outputs.interface_2_name
  advertise_mode            = "CUSTOM"
  advertised_ip_ranges {
      range = "10.71.248.0/21"
    }
  advertised_ip_ranges {
      range = "10.71.247.0/24"
    }
  advertised_ip_ranges {
      range = "10.71.239.64/26"
    }
}


