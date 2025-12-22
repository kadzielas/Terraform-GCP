module "project" {
  source = "../../modules/project"

  project_id = var.project_id

  disable_on_destroy         = false
  disable_dependent_services = false

  services = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-component.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}

module "workload_identity_pools" {
  source = "../../modules/workload_identity_pool"

  workload_identity_pool_id = "${local.prefix}wip"
  display_name              = "${local.prefix}wip"
  description               = "A workload identity pool for my project."
  disabled                  = false

  oidc_providers = {
    github-provider = {
      display_name        = "${local.prefix}gh-actions-provider"
      description         = "GitHub Actions OIDC provider"
      disabled            = false
      attribute_condition = "attribute.repository == 'kadzielas/Terraform-GCP' && attribute.aud == '159706121'"
      attribute_mapping = {
        "google.subject"       = "assertion.sub"
        "attribute.actor"      = "assertion.actor"
        "attribute.aud"        = "assertion.aud"
        "attribute.ref"        = "assertion.ref"
        "attribute.repository" = "assertion.repository"
      }
      oidc_issuer_uri   = "https://token.actions.githubusercontent.com"
      allowed_audiences = ["159706121"]
    }
  }
}
