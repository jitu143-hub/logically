terraform {
  backend "gcs" {}
}

resource "kubernetes_persistent_volume_claim" "geotrade-sc-pvc" {
  metadata {
    name = var.pvc_name
    namespace = var.namespace
    annotations = {
      "volume.beta.kubernetes.io/storage-class" = var.storage_class_name
    }
  }
  spec {
    access_modes = var.access_modes
    resources {
      requests = {
        storage = var.storage_size
      }
    }
    storage_class_name = var.storage_class_name
  }
}