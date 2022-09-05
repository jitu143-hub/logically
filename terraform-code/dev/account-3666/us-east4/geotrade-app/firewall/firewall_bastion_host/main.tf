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

module "firewall_rules" {
  source       = "/Users/pavanwadhe/Downloads/work/Mouritech Work/iac-geotrade-application/terraform-modules/firewall-rules"
  project_id   = var.project_id
  network_name = data.terraform_remote_state.vpc.outputs.network_name

  rules = [{
    name                    = "allow-ssh-${var.project_id}"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["allow-ssh-${var.project_id}"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}