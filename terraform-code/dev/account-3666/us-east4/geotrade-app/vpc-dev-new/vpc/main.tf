terraform {
  backend "gcs" {}
}

module "geotrade-app-vpc" {
    source  = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-application/terraform-modules/vpc"

    project_id   = var.project_id
    network_name = "${var.project_name}-vpc-${var.env_name}-new"

    shared_vpc_host = false
    mtu       = 1460
}
