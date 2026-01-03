module "workload_identity_pools" {
  source = "../../modules/workload_identity_pool"

  workload_identity_pool_id = "${local.prefix}wip"
  display_name              = "${local.prefix}wip"
  description               = "A workload identity pool for my project."
  disabled                  = false

  oidc_providers = {
    gh-pvd = {
      display_name        = "${local.prefix}gh-actions-provider"
      description         = "GitHub Actions OIDC provider"
      disabled            = false
      attribute_condition = "assertion.repository == \"kadzielas/Terraform-GCP\""
      attribute_mapping = {
        "google.subject"       = "assertion.sub"
        "attribute.ref"        = "assertion.ref"
        "attribute.repository" = "assertion.repository"
      }
      oidc_issuer_uri = "https://token.actions.githubusercontent.com"
    }
  }
  depends_on = [module.sa]
}
