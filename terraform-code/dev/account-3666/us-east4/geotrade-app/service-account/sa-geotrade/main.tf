terraform {
  backend "gcs" {}
}

resource "google_service_account" "sa_geotrade-migration" {
  account_id   = var.project_id
  display_name = "sa-${var.project_id}-${var.env_name}"
  project = var.project_id
}

resource "google_project_iam_member" "sa_owner_binding" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.sa_geotrade-migration.email}"
}

# resource "google_service_account_key" "sa_key_geotrade-migration" {
#   service_account_id = google_service_account.sa_geotrade-migration.name
#   public_key_type    = "TYPE_X509_PEM_FILE"
#   provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
#     command = "echo '${google_service_account_key.sa_key_geotrade-migration.private_key}' > ../../../${var.project_id}.json"
#   }
# }
