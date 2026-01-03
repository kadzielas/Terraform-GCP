output "network" {
  value       = google_compute_network.main
  description = "The VPC resource being created"
}

output "network_id" {
  value       = google_compute_network.main.id
  description = "The ID of the VPC being created"
}

output "subnets" {
  value = {
    for k, s in google_compute_subnetwork.subnet : k => {
      id        = s.id
      self_link = s.self_link
      name      = s.name
      region    = s.region
    }
  }
}

output "subnet_ids" {
  value = { for k, s in google_compute_subnetwork.subnet : k => s.id }
}

output "firewall_rules" {
  value       = google_compute_firewall.default_allow
  description = "The created firewall rule resources"
}
