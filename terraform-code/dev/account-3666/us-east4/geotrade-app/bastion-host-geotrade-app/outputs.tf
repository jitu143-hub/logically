output "network_ip" {
  description = "The name of the database instance"
  value       = google_compute_instance.new_compute.network_interface.0.network_ip
}