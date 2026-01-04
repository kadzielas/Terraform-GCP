module "sa" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id

  accounts = {
    "${local.prefix}sa-github" = {
      display_name = "DEV SA for GitHub"
      project_roles = [
        "roles/viewer",
        "roles/storage.objectAdmin",
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
      display_name = "DEV SA for Compute"
      project_roles = [
        "roles/compute.admin",
        "roles/iam.serviceAccountUser",
        "roles/cloudkms.cryptoKeyEncrypterDecrypter",
      ]
      iam_bindings = []
    }

  }
  depends_on = [module.project]
}
