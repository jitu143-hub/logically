terraform {
  backend "gcs" {}
}


data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc-dev-new/vpc/terraform.tfstate"
  }
}

resource "google_compute_instance" "new_compute" {
  name         = "${var.project_name}-app-bastion-host-dev-new"
  machine_type = "e2-medium"
  zone         = var.gcp_zone

  tags = ["allow-ssh-${var.project_id}"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = data.terraform_remote_state.vpc.outputs.network_name
    subnetwork = "dev-geotrade-app-central-services-subnet"

    access_config {
      // Ephemeral IP
    }
  }

  # metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
}