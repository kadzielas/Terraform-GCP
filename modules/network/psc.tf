resource "google_compute_global_address" "psc" {
  provider     = google-beta
  project      = var.project_id
  name         = var.private_service_connect_name
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = google_compute_network.vpc.id
  address      = var.private_service_connect_ip
}

resource "google_compute_global_forwarding_rule" "fr_psc" {
  project               = var.project_id
  name                  = var.forwarding_rule_name
  target                = var.forwarding_rule_target
  network               = google_compute_network.vpc.id
  ip_address            = google_compute_global_address.psc.id
  load_balancing_scheme = ""
}
