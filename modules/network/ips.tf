resource "google_compute_address" "static_ip" {
  name   = "my-vm-static-ip"
  region = var.region
}
