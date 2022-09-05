terraform {
  source = "${path_relative_from_include()}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  pvc_name =  "pvc-kafka-dev"
  storage_size  = "30Gi"
  access_modes  = ["ReadWriteOnce"]
  storage_class_name  = "sc-geotrade-kafka-dev"
  # pv_name = "pv-nfs-redis"
  namespace = "kafka"
}