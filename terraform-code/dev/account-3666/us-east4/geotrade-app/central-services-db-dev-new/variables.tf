variable "project_id" {
  description = "The project ID to host the network in"
}

variable "gcp_region" {
  description = "region"
}

variable "env_name" {
  description = "region"
}

variable "gcp_account_short_id" {
  description = "region"
}

variable "gcp_region_short_id" {
  description = "region"
}

variable "project_name" {
  description = "project name"
}

variable "local_dir" {
  description = "project name"
}

variable "dev_db_postgres_version" {
  description = "The engine version of the database, e.g. `POSTGRES_9_6`. See https://cloud.google.com/sql/docs/db-versions for supported versions."
  type        = string
  #default     = "POSTGRES_13"
}

variable "dev_db_machine_type" {
  description = "The machine type to use, see https://cloud.google.com/sql/pricing for more details"
  type        = string
  #default     = "db-f1-micro"
}

variable "dev_db_name" {
  description = "Name for the db"
  type        = string
  #default     = "mt-master"
}

variable "dev_db_instance_name" {
  description = "Name for the db"
  type        = string
  #default     = "mt-test"
}

variable "dev_db_master_user_name" {
  description = "The username part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_name so you don't check it into source control."
  type        = string
  #default     = "mt-master"
}

variable "dev_db_master_user_password" {
  description = "The password part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_password so you don't check it into source control."
  type        = string
  #default     = "mt-master"
}
