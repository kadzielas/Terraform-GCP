resource "google_project_service" "project" {
  for_each = toset(var.services)

  project = var.project_id

  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services

  service = each.value
}
