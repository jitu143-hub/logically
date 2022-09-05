output "network" {
  value       = module.geotrade-app-vpc.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = module.geotrade-app-vpc.network.name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.geotrade-app-vpc.network.self_link
  description = "The URI of the VPC being created"
}

output "network_id" {
 value = module.geotrade-app-vpc.network.id
 description = "Id of the network"
}