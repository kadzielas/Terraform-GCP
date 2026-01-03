locals {
  prefix = "dev-alc25-"
  labels = {
    environment = "dev"
    project     = "sandbox"
    destination = "github"
  }
  github_roles = {
    "roles/iam.workloadIdentityUser" = true
  }
  service_accounts_roles = flatten([
    for name, roles in module.gcp_sa.accounts_project_roles : [
      for role in roles : {
        role  = role
        email = module.gcp_sa.service_account_emails[name]
      }
    ]
  ])

  all_project_iam = {
    for role in distinct([for item in local.service_accounts_roles : item.role]) : role => [
      for item in local.service_accounts_roles : "serviceAccount:${item.email}"
      if item.role == role
    ]
  }
}
