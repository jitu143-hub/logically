terraform {
  backend "gcs" {}
}

resource "kubernetes_persistent_volume" "geotrade-nfs-pv" {
  metadata {
    name = var.pv_name
  }
  spec {
    storage_class_name = var.storage_class_name
    persistent_volume_reclaim_policy = var.persistent_volume_reclaim_policy
    capacity = {
      storage = var.storage_size
    }
    access_modes = var.access_modes
    persistent_volume_source {
      nfs {
        path = var.path
        server = var.nfs_server
      }
    }
  }
}