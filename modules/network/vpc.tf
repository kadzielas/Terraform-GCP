resource "google_compute_network" "vpc" {
  provider                = google-beta
  project                 = var.project_id
  name                    = var.vpc_name
  routing_mode            = var.routing_mode
  auto_create_subnetworks = false
}
