resource "google_compute_firewall" "default_allow" {
  for_each = length(var.rules) > 0 ? { for r in var.rules : r.name => r } : {}

  name    = each.value.name
  network = google_compute_network.vpc.name

  direction               = each.value.direction
  disabled                = each.value.disabled
  source_ranges           = each.value.source_ranges
  destination_ranges      = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts
  priority                = each.value.priority

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}

