output "service_account_id" {
  value       = google_service_account.sa_geotrade-migration.id
  description = "service account ID"
}

output "etag" {
  value       = google_project_iam_member.sa_owner_binding.etag 
  description = "etag"
}

output "unique_id" {
  value       = google_service_account.sa_geotrade-migration.unique_id 
  description = "unique_id"
}


