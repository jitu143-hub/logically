output "peer_1_id" {
  description = "The name of the database instance"
  value       = google_compute_router_peer.vpn-router-peer1-gcp-onprem.id
}

output "peer_1_ip_address" {
  description = "The name of the database instance"
  value       = google_compute_router_peer.vpn-router-peer1-gcp-onprem.ip_address
}

output "peer_1_name" {
  description = "The name of the database instance"
  value       = google_compute_router_peer.vpn-router-peer1-gcp-onprem.name
}

output "peer_2_id" {
  description = "The name of the database instance"
  value       = google_compute_router_peer.vpn-router-peer2-gcp-onprem.id
}

output "peer_2_ip_address" {
  description = "The name of the database instance"
  value       = google_compute_router_peer.vpn-router-peer2-gcp-onprem.ip_address
}

output "peer_2_name" {
  description = "The name of the database instance"
  value       = google_compute_router_peer.vpn-router-peer2-gcp-onprem.name
}