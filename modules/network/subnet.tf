resource "google_compute_subnetwork" "subnet" {
  for_each = local.subnets

  network                  = google_compute_network.main.name
  region                   = each.value.subnet_region
  name                     = each.value.subnet_name
  ip_cidr_range            = each.value.subnet_ip
  private_ip_google_access = lookup(each.value, "subnet_private_access", "false")

  dynamic "secondary_ip_range" {
    for_each = contains(keys(var.secondary_ranges), each.value.subnet_name) == true ? var.secondary_ranges[each.value.subnet_name] : []

    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}
