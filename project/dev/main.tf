module "project" {
  source = "../../modules/project"

  project_id = var.project_id

  disable_on_destroy         = false
  disable_dependent_services = false

  services = local.services
}
