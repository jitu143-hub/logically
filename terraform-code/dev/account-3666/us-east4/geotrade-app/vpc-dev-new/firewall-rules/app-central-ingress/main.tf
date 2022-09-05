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

module "firewall_rules" {
  source       = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-application/terraform-modules/firewall-rules"
  project_id   = var.project_id
  network_name = data.terraform_remote_state.vpc.outputs.network_name

  rules = [{
    name                    = "dev-geotrade-app-central-ingress"
    description             = "opening port 8443 from master to nodes for ingress to work"
    direction               = "INGRESS"
    priority                = null
    ranges                  = [var.dev_app_central_master_ipv4_cidr_block]
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