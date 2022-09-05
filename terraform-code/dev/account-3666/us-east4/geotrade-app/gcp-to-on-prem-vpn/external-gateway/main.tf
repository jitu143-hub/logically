terraform {
  backend "gcs" {}
}

resource "google_compute_external_vpn_gateway" "vpn-external-gateway-gcp-onprem" {
  name            = "${var.project_id}-external-vpn-gateway-gcp-onprem"
  project         = var.project_id
  redundancy_type = "TWO_IPS_REDUNDANCY"
  description     = "An externally managed VPN gateway"

  interface {
    id         = 0
    ip_address = var.onprem_ext_vpn_gateway_ip_1
  }

  interface {
    id         = 1
    ip_address = var.onprem_ext_vpn_gateway_ip_2
  }
}