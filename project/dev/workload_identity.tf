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
  depends_on = [module.service_accounts]
}

resource "google_service_account_iam_binding" "wif_binding" {
  for_each = local.github_roles

  service_account_id = module.service_accounts.service_accounts["${local.prefix}sa-github"].name
  role               = each.key

  members = [
    "principal://iam.googleapis.com/projects/492774125441/locations/global/workloadIdentityPools/dev-alc25-wip/subject/google.subject",
    "principalSet://iam.googleapis.com/projects/492774125441/locations/global/workloadIdentityPools/dev-alc25-wip/attribute.repository/kadzielas/Terraform-GCP"
  ]

  depends_on = [module.workload_identity_pools]

}
