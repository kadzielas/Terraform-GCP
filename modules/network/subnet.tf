resource "google_compute_subnetwork" "subnet" {
  for_each = var.subnets

  name                     = each.value.subnet_name
  ip_cidr_range            = each.value.subnet_ip
  region                   = each.value.subnet_region
  network                  = google_compute_network.custom-test.id
  private_ip_google_access = each.value.subnet_private_access == "true"
}
