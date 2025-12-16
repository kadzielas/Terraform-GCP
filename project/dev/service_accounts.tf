module "service_accounts" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id

  accounts = {
    "roles/storage.objectAdmin" = {
      display_name         = "${locals.prefix}sa-github"
      is_workload_identity = true
    }
  }
}
