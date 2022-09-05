terraform {
  backend "gcs" {}
}

module "geotrade-app-vpc" {
    source  = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-tooling/terraform-modules/vpc"

    project_id   = var.project_id
    network_name = "${var.project_name}-vpc-${var.env_name}-${var.gcp_region_short_id}-${var.gcp_account_short_id}"

    shared_vpc_host = false
    mtu       = 1460
}
