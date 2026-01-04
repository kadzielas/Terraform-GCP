output "network" {
  value       = google_compute_network.vpc
  description = "The VPC resource being created"
}

output "network_id" {
  value       = google_compute_network.vpc.id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value = google_compute_network.vpc.self_link
}

output "subnets" {
  value = { for k, s in google_compute_subnetwork.subnet : k => s }
}

output "subnet_ids" {
  value = { for k, s in google_compute_subnetwork.subnet : k => s.id }
}

output "private_service_connect_name" {
  value       = google_compute_global_address.psc.name
  description = "Private service connect name"
}

output "private_service_connect_ip" {
  value       = google_compute_global_address.psc.address
  description = "Private service connect ip"
}

output "firewall_rules" {
  value       = google_compute_firewall.default_allow
  description = "The created firewall rule resources"
}
