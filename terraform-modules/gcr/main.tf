provider "google" {
  credentials = file("mouritech-digital-ip-37cfdeabf7f1.json.jason")  
  project = var.project_name
  region = var.region
  zone = var.zone
}

#----------------------------------------------------------------------------------------------
#  Enable APIs
#      - Cloud Function
#      - Pub/Sub
#      - Firestore
#----------------------------------------------------------------------------------------------


module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id    = var.project_name
  activate_apis =  [
    "cloudresourcemanager.googleapis.com",
    "cloudfunctions.googleapis.com",
    "pubsub.googleapis.com",
    "firestore.googleapis.com",
    "run.googleapis.com",
    "sourcerepo.googleapis.com",
    "cloudbuild.googleapis.com",
    "containerregistry.googleapis.com",
  ]

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

resource "google_sourcerepo_repository" "repo" {
  name = var.repository_name
  depends_on = [module.project_services.project_id]
}


#----------------------------------------------------------------------------------------------
#  Cloud Build
#  -  Create trigger
#  -  set permission
#----------------------------------------------------------------------------------------------

data "google_project" "project" {
}

resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  name = var.repository_name
  description = "Cloud Source Repository Trigger ${var.repository_name} (${var.branch_name})"
  trigger_template {
    repo_name = var.repository_name
    branch_name = var.branch_name
  }

  filename = "cloudbuild.yaml"
  substitutions = {
    _SERVICE_NAME= var.service_name
    _REGION = var.region
  }
}


resource "google_project_iam_binding" "binding" {
  members = ["serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"]
  role = "roles/run.admin"
  depends_on = [module.project_services.project_id]
}

resource "google_project_iam_binding" "sa" {
  members = ["serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"]
  role = "roles/iam.serviceAccountUser"
  depends_on = [module.project_services.project_id]
}
