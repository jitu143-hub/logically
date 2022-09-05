variable "project_id" {
  type        = string
  description = "type your account_id"
}

variable "env_name" {
  type        = string
  description = "env name"
}

variable "user_name" {
  type        = string
  description = "iam user"
}

variable "user_role" {
  type        = string
  description = "roles/owner, roles/editor, roles/viewer. for more information refer https://cloud.google.com/iam/docs/understanding-roles"
  default    = "roles/owner"
}

