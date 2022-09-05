output "tunnel_1_id" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel1-gcp-onprem.id
}

output "tunnel_1_peer_ip" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel1-gcp-onprem.peer_ip
}

output "tunnel_1_self_link" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel1-gcp-onprem.self_link
}

output "tunnel_1_tunnel_id" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel1-gcp-onprem.tunnel_id
}

output "tunnel_2_id" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel2-gcp-onprem.id
}

output "tunnel_2_peer_ip" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel2-gcp-onprem.peer_ip
}

output "tunnel_2_self_link" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel2-gcp-onprem.self_link
}

output "tunnel_2_tunnel_id" {
  description = "The name of the database instance"
  value       = google_compute_vpn_tunnel.vpn-tunnel2-gcp-onprem.tunnel_id
}