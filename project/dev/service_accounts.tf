module "sa" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id

  accounts = {
    "${local.prefix}sa-github" = {
      display_name = "dev-sa-imp"
      project_roles = [
        "roles/storage.objectAdmin",
        "roles/viewer"
      ]
      iam_bindings = [
        { role    = "roles/iam.serviceAccountTokenCreator"
          members = local.wi_members
        },
        {
          role    = "roles/iam.workloadIdentityUser"
          members = local.wi_members
        }

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
