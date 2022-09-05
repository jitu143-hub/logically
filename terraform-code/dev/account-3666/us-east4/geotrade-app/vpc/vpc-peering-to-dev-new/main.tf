terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "vpc-dev-app" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc-dev-new/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc-db-app" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc/vpc/terraform.tfstate"
  }
}


resource "google_compute_network_peering" "peering-db-to-dev-app" {
  name         = "peering-db-to-dev-app"
  network      = data.terraform_remote_state.vpc-db-app.outputs.network_id
  peer_network = data.terraform_remote_state.vpc-dev-app.outputs.network_id
}




