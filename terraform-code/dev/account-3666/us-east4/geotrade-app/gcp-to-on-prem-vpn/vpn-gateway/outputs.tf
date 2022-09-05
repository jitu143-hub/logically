output "vpn-gateway-ip1" {
  description = "The name of the database instance"
  value       = google_compute_ha_vpn_gateway.gcp-onprem-ha_gateway.vpn_interfaces.0.ip_address
}

output "vpn-gateway-ip2" {
  description = "The name of the database instance"
  value       = google_compute_ha_vpn_gateway.gcp-onprem-ha_gateway.vpn_interfaces.1.ip_address
}

output "id" {
  description = "The name of the database instance"
  value       = google_compute_ha_vpn_gateway.gcp-onprem-ha_gateway.id
}