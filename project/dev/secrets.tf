resource "google_project_service_identity" "secretmanager" {
  provider = google-beta
  project  = var.project_id
  service  = "secretmanager.googleapis.com"
}

module "secrets" {
  source = "../../modules/secret_manager"

  project_id          = var.project_id
  deletion_protection = false
  managers            = var.secret_managers
  labels              = local.labels

  secrets = [
    {
      name = "sql-main-password"
      accessors = [
        local.principals.main,
      ]
    },
  ]

  replications = [
    {
      location     = var.region
      kms_key_name = module.encryption.cmek_name
    },
  ]

  depends_on = [google_project_service_identity.secretmanager]
}
