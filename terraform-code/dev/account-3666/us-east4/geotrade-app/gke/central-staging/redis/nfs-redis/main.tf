terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc/vpc/terraform.tfstate"
  }
}

resource "google_filestore_instance" "geotrade-nfs-instance" {
  provider = google-beta
  project = var.project_id
  name = "${var.project_id}-${var.env_name}-redis-nfs-server"
  zone = var.gcp_zone
  tier = "BASIC_HDD"

  file_shares {
    capacity_gb = 1048
    name        = "nfs_redis"

    nfs_export_options {
      ip_ranges = ["10.11.12.0/28","10.11.0.0/22","10.11.4.0/22","10.11.8.0/22","10.11.13.0/24"]
      access_mode = "READ_WRITE"
      squash_mode = "NO_ROOT_SQUASH"
   }
  }

  networks {
    network = data.terraform_remote_state.vpc.outputs.network_name
    modes   = ["MODE_IPV4"]
  }
}
