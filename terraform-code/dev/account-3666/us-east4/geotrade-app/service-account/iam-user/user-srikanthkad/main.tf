terraform {
  backend "gcs" {}
}

resource "google_project_iam_member" "member" {
  project = var.project_id
  role    = var.user_role
  member  = "user:${var.user_name}"
}