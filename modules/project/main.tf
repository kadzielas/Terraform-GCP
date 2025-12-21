resource "google_project_service" "project" {
  project = var.project_id

  service                    = var.service
  disable_on_destroy         = false
  disable_dependent_services = false

}
