terraform {
  source = "${path_relative_from_include()}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  pvc_name =  "pvc-loki"
  storage_size  = "50Gi"
  access_modes  = ["ReadWriteOnce"]
  storage_class_name  = "sc-geotrade-loki"
  # pv_name = "pv-nfs-jenkins"
  namespace = "loki"
}