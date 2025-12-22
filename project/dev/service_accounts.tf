module "service_accounts" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id

  accounts = {
    "${local.prefix}sa-github" = {
      display_name = "Service Account for GitHub Actions"
      roles = [
        "roles/storage.objectAdmin",
        "roles/iam.workloadIdentityUser"
      ]
      members = [
        "principalSet://iam.googleapis.com/${module.workload_identity_pools.workload_identity_pool_id}/attribute.repository/kadzielas/Terraform-GCP"
      ]
      is_workload_identity = true
    }
  }

  depends_on = [module.project]
}
