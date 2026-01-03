module "sa" {
  source     = "../../modules/service_account"
  project_id = var.gcp_project_id

  accounts = {
    "${local.prefix}sa-github" = {
      display_name = "dev-sa-imp"
      project_roles = [
        "roles/storage.objectAdmin",
        "roles/iam.workloadIdentityUser",
      ]
      iam_bindings = [
        "roles/iam.serviceAccountTokenCreator"
      ]
    },

    "${local.prefix}sa-compute" = {
      display_name = "dev-sa-imp"
      project_roles = [
        "roles/compute.admin",
        "roles/iam.serviceAccountUser",
      ]
      iam_bindings = []
    }

  }
  depends_on = [module.project]
}
