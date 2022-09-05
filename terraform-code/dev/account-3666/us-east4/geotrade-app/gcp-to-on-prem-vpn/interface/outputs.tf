output "interface_1_id" {
  description = "The name of the database instance"
  value       = google_compute_router_interface.vpn-router-interface1-gcp-onprem.id
}

output "interface_2_id" {
  description = "The name of the database instance"
  value       = google_compute_router_interface.vpn-router-interface2-gcp-onprem.id
}

output "interface_1_name" {
  description = "The name of the database instance"
  value       = google_compute_router_interface.vpn-router-interface1-gcp-onprem.name
}

output "interface_2_name" {
  description = "The name of the database instance"
  value       = google_compute_router_interface.vpn-router-interface2-gcp-onprem.name
}