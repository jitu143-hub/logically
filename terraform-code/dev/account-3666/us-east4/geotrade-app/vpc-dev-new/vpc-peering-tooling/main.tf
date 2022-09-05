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


resource "google_compute_network_peering" "peering-dev-geotrade-app-to-tooling" {
  name         = "peering-dev-geotrade-app-to-tooling"
  network      = data.terraform_remote_state.vpc-dev-app.outputs.network_id
  peer_network = "projects/geotrade-migration/global/networks/geotrade-tooling-vpc-dev-ue4-3666"
}




