# google_client_config and kubernetes provider must be explicitly specified like the following.
terraform {
  backend "gcs" {}
}

data "google_client_config" "default" {}

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "private_subnet" {
  backend = "gcs"
  config = {
    # Replace this with your bucket name
    bucket = "geotrade-tfstate-${var.env_name}-${var.gcp_account_short_id}"
    prefix = "${var.env_name}/${var.local_dir}/${var.gcp_region}/${var.project_name}/vpc/subnets/subnet-private/terraform.tfstate"
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-application/terraform-modules/gke"
  project_id                 = var.project_id
  name                       = "${var.project_name}-central-cluster-${var.env_name}"
  region                     = var.gcp_region
  zones                      = ["us-east4-a", "us-east4-b", "us-east4-c"]
  network                    = data.terraform_remote_state.vpc.outputs.network_name
  subnetwork                 = "geotrade-app-central-services-subnet-dev"
  ip_range_pods              = "geotrade-app-central-services-ip-range-pods-dev"
  ip_range_services          = "geotrade-app-central-services-ip-range-services-dev"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = var.app_central_master_ipv4_cidr_block

  node_pools = [
    {
      name                      = "node-pool-new"
      machine_type              = "e2-standard-4"
      node_locations            = "us-east4-b"
      min_count                 = 2
      max_count                 = 10
      local_ssd_count           = 0
      disk_size_gb              = 20
      disk_type                 = "pd-standard"
      image_type                = "COS"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = var.service_account_email
      preemptible               = false
      initial_node_count        = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}