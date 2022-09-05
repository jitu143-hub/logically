terraform {
  backend "gcs" {}
}

resource "kubernetes_storage_class" "sc-geotrade-kafka-dev" {
  metadata {
    name = "sc-geotrade-kafka-dev"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"
  parameters = {
    type = "pd-standard"
  }
  # mount_options = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
}
