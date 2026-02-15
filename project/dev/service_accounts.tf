module "sa" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id

  accounts = {
    "${local.prefix}sa-github" = {
      display_name = "DEV SA for GitHub"
      sa_bindings  = []
    },

    "${local.prefix}sa-compute" = {
      display_name = "DEV SA for Compute"
      sa_bindings  = []
    }

  }
  depends_on = [module.project]
}
