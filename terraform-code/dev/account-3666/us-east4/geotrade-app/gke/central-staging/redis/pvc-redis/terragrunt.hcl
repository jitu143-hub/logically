terraform {
  source = "${path_relative_from_include()}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  pvc_name =  "pvc-redis"
  storage_size  = "50Gi"
  access_modes  = ["ReadWriteOnce"]
  storage_class_name  = "sc-geotrade-redis-staging"
  # pv_name = "pv-nfs-redis"
  namespace = "redis"
}