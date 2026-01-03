output "network" {
  value       = google_compute_network.main
  description = "The VPC resource being created"
}

output "network_id" {
  value       = google_compute_network.main.id
  description = "The ID of the VPC being created"
}

output "subnets" {
  value       = google_compute_subnetwork.subnet
  description = "The created subnet resources"
}

output "firewall_rules" {
  value       = google_compute_firewall.default_allow
  description = "The created firewall rule resources"
}
