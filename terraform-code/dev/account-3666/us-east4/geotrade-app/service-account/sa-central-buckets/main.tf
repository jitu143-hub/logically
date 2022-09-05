terraform {
  backend "gcs" {}
}

resource "google_service_account" "sa_central-services-bucket-dev" {
  account_id   = "central-services-bucket"
  display_name = "sa-central-services-bucket-${var.env_name}"
  project = var.project_id
}

resource "google_project_iam_member" "sa_creator_binding" {
  project = var.project_id
  role    = "roles/storage.objectCreator"
  member  = "serviceAccount:${google_service_account.sa_central-services-bucket-dev.email}"
}

resource "google_project_iam_member" "sa_viewer_binding" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.sa_central-services-bucket-dev.email}"
}

resource "google_service_account_key" "sa_key_central-services-bucket-dev" {
  service_account_id = google_service_account.sa_central-services-bucket-dev.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${google_service_account_key.sa_key_central-services-bucket-dev.private_key}' > ../../../sa_central-services-bucket-dev.json"
  }
}
