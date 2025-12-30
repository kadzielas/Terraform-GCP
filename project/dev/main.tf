module "project" {
  source = "../../modules/project"

  project_id = var.project_id

  disable_on_destroy         = false
  disable_dependent_services = false

  services = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-component.googleapis.com",
    "sts.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}
