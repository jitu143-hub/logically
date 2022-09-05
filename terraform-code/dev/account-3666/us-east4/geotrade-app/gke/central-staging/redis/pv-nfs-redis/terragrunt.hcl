terraform {
  source = "${path_relative_from_include()}"
}

dependency "nfs-redis" {
  config_path = "../../redis/nfs-redis"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    pv_name = "pv-nfs-redis"
    storage_class_name  = "sc-geotrade-redis"
    persistent_volume_reclaim_policy  = "Retain"
    storage_size  = "5Gi"
    access_modes  = ["ReadWriteMany"]
    path = "/nfs_redis"
    nfs_server = "10.237.94.226"
}
