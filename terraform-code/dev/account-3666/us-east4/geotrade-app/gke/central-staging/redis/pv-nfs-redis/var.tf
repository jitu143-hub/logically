variable "pv_name" {
  description = "Name of the pv"
  type        = string
}

variable "storage_class_name" {
  description = "Name of the storage class"
  type        = string
}

variable "persistent_volume_reclaim_policy" {
  description = "Volume retain policy"
  type        = string
}

variable "storage_size" {
  description = "Size of storage"
  type        = string
}

variable "access_modes" {
  description = "Access modes"
  type        = list
  default = []
}

variable "path" {
  description = "Folder path within EFS"
  type        = string
}

variable "nfs_server" {
  description = "Name of the EFS server"
  type        = string
}