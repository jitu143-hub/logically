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

resource "google_compute_router" "gcp-onprem-cloud-router" {
  name    = "${var.project_id}-gcp-onprem-cloud-router"
  network = data.terraform_remote_state.vpc.outputs.network_self_link
  bgp {
    asn               = 64512
    advertise_mode    = "CUSTOM"
    advertised_ip_ranges {
      range = "10.71.248.0/21"
    }
    advertised_ip_ranges {
      range = "10.71.247.0/24"
    }
    advertised_ip_ranges {
      range = "10.71.239.64/26"
    }
   
  }
}


