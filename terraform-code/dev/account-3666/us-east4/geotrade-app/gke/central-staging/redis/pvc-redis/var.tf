variable "pvc_name" {
  description = "Name of the pvc"
  type        = string
}

variable "namespace" {
  description = "Namespace of the pvc"
  type        = string
}

variable "storage_class_name" {
  description = "Name of the storage class"
  type        = string
}

variable "access_modes" {
  description = "Access modes"
  type        = list
  default = []
}

variable "storage_size" {
  description = "Size of storage"
  type        = string
}