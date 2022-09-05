locals {
  project_name = "geotrade-app"
  gcp_project_name = "GeoTrade Migration"
  project_id = "geotrade-migration"
  gke_cluster_name= ""
  gke_version = "1.21"
  gke_node_group_name = ""
  domain_name = ""
  service_account_email = "geotrade-migration@geotrade-migration.iam.gserviceaccount.com"

  # central
  app_central_subnet_networkname = "geotrade-app-central-services-subnet-dev"
  app_subnet_public_ip = "10.10.0.0/24"
  app_central_master_ipv4_cidr_block = "10.11.12.0/28"
  app_central_subnet_private_ip = "10.11.0.0/22"
  #  "10.11.4.0/22"
  app_central_subnet_range_pod_ip = "10.11.8.0/24"
  # "10.11.8.0/22"
  app_central_subnet_range_service_ip = "10.11.4.0/22"
  app_central_subnet_db_ip = "10.11.13.0/24"
  app_central_subnet_private_ip_new = "10.71.248.0/21"

  #ORG
  app_org_subnet_networkname = "geotrade-app-org-subnet-dev"
  app_org_master_ipv4_cidr_block = "10.18.0.0/28"
  app_org_subnet_private_ip = "10.15.0.0/20"
  app_org_subnet_range_pod_ip = "10.16.0.0/16"
  app_org_subnet_range_service_ip = "10.17.0.0/16"
  app_org_subnet_db_ip = "10.19.0.0/20"

  #SQL
  db_name = "central-services-db-dev"
  db_instance_name = "geotrade-app-central-sql-instance-dev"
  db_master_user_name = "central_user"
  db_master_user_password = "welcome@678"
  db_machine_type = "db-f1-micro"
  db_postgres_version = "POSTGRES_13"

  #SQL-dev-new
  dev_db_name = "central-services-db-dev-new"
  dev_db_instance_name = "geotrade-app-central-sql-instance-devlopment-new"
  dev_db_master_user_name = "central_user_dev"
  dev_db_master_user_password = "welcome@678"
  dev_db_machine_type = "db-custom-4-15360"
  dev_db_postgres_version = "POSTGRES_13"


  #kafka
  app_central_kafka_machine_type = "e2-medium"
  app_central_kafka_cluster_machine_type = "e2-medium"
  app_central_kafka_image = "bitnami-launchpad/bitnami-kafka-2-8-0-4-r04-linux-debian-10-x86-64-nami"
  app_central_kafka_brokers_count = "1"
  app_central_kafka_zookeeper_nodes = "1"

# staging-VPN
  onprem_ext_vpn_gateway_ip_1 = "69.160.179.69"
  onprem_ext_vpn_gateway_ip_2 = "69.160.183.126"
  gcp_onprem_shared_secret_t1 = "ABAL8YcKg#R#FAld"
  gcp_onprem_shared_secret_t2 = "F3qvwTYjU5ShT#6f"
  gcp_onprem_router_peer1_ip_address = "169.254.0.2"
  gcp_onprem_router_peer2_ip_address = "169.254.0.6"
  peer_asn = "65140"

  # geoverse internal system
  geoverse-internal_subnet_networkname      = "geotrade-app-geoverse-internal-subnet-staging"
  #geoverse_subnet_public_ip                = "10.71.239.0/24"
  geoverse_internal_master_ipv4_cidr_block  = "10.71.238.64/28"
  geoverse_internal_subnet_private_ip       = "10.71.238.128/27"
  geoverse_internal_subnet_range_pod_ip     = "10.71.239.64/26"
  geoverse_internal_subnet_range_service_ip = "10.71.237.64/26"

  # test organization
  test_org_subnet_networkname = "geotrade-app-test-org-subnet"
  test_org_master_ipv4_cidr_block = "10.5.0.0/28"
  test_org_subnet_private_ip = "10.6.0.0/20"
  test_org_subnet_range_pod_ip = "10.7.0.0/16"
  test_org_subnet_range_service_ip = "10.8.0.0/16"

  # central dev-new
  dev_app_central_subnet_networkname = "dev-geotrade-app-central-services-subnet"
  dev_app_central_master_ipv4_cidr_block = "10.24.6.64/28"
  dev_app_central_subnet_private_ip = "10.24.6.0/26"
  dev_app_central_subnet_range_pod_ip = "10.24.8.0/21"
  dev_app_central_subnet_range_service_ip = "10.24.16.0/21"

  # new dev geoverse internal system
  dev_geoverse-internal_subnet_networkname      = "geotrade-app-geoverse-internal-subnet-dev"
  dev_geoverse_internal_master_ipv4_cidr_block  = "10.71.238.80/28"
  dev_geoverse_internal_subnet_private_ip       = "10.71.238.160/27"
  dev_geoverse_internal_subnet_range_pod_ip     = "10.71.239.128/26"
  dev_geoverse_internal_subnet_range_service_ip = "10.71.237.128/26"

}


