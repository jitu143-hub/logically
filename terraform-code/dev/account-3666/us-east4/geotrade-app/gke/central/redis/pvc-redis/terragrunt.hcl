terraform {
  source = "${path_relative_from_include()}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  pvc_name =  "pvc-redis"
  storage_size  = "30Gi"
  access_modes  = ["ReadWriteOnce"]
  storage_class_name  = "sc-geotrade-redis"
  # pv_name = "pv-nfs-redis"
  namespace = "redis"
}