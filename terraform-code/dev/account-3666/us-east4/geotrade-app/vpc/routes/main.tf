terraform {
  backend "gcs" {}
}

module "geo-vpc-routes" {
    source  = "/mnt/c/Users/srikanthkad/git/gcp-terraform-module/routes"

    project_id   = var.project_id
    network_name = "vpc-${var.project_id}-${var.env_name}-${var.gcp_region_short_id}-${var.gcp_account_short_id}"

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
        {
            name                   = "app-proxy"
            description            = "route through proxy to reach app"
            destination_range      = "10.50.10.0/24"
            tags                   = "app-proxy"
            next_hop_instance      = "app-proxy-instance"
            next_hop_instance_zone = "us-east4-b"
        },
    ]
}