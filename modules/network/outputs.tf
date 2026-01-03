output "network" {
  value       = google_compute_network.network
  description = "The VPC resource being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The ID of the VPC being created"
}

output "subnets" {
  value       = google_compute_subnetwork.subnetwork
  description = "The created subnet resources"
}

output "firewall_rules" {
  value       = google_compute_firewall.rules
  description = "The created firewall rule resources"
}
