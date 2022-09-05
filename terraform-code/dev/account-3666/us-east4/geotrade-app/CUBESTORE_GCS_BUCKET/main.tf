/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
terraform {
  backend "gcs" {}
}

module "cubestore-gcs-storage-bucket" {
  source = "/mnt/c/Users/jitendrana/Documents/iac-geotrade-application/terraform-modules/simple-bucket"

  name       = "cubestore-gcs-storage-bucket"
  project_id = var.project_id
  location   = var.gcp_region
  bucket_policy_only = false



  # iam_members = [{
  #   role   = "roles/storage.objectCreator"
  #   role   = "roles/storage.objectViewer"
  #   member = "serviceAccount:central-services-bucket@geotrade-migration.iam.gserviceaccount.com"
  # }]
}