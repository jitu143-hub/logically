output "service_account_id" {
  value       = google_service_account.sa_central-services-bucket-dev.id
  description = "service account ID"
}

output "etagCreator" {
  value       = google_project_iam_member.sa_creator_binding.etag 
  description = "etag"
}

output "etagViewer" {
  value       = google_project_iam_member.sa_viewer_binding.etag 
  description = "etag"
}

output "unique_id" {
  value       = google_service_account.sa_central-services-bucket-dev.unique_id 
  description = "unique_id"
}


