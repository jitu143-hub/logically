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
    name                    = "geotrade-app-central-staging-ingress"
    description             = "opening port 8443 from master to nodes for ingress to work"
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["10.71.249.0/28"]
    source_tags             = null
    source_service_accounts = [var.service_account_email]
    target_tags             = null
    target_service_accounts = [var.service_account_email]
    allow = [{
      protocol = "tcp"
      ports    = ["80","443","8443"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}