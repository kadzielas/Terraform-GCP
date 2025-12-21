module "service_accounts" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id

  accounts = {
    "${local.prefix}sa-github" = {
      display_name = "Service Account for GitHub Actions"
      roles = [
        "roles/storage.objectAdmin"
      ]
      is_workload_identity = true
    }
  }

  depends_on = [module.project]
}
