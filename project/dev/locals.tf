locals {
  prefix = "dev-alc25-"
  labels = {
    environment = "dev"
    project     = "sandbox"
    destination = "github"
  }
  wi_members = [
    "principalSet://iam.googleapis.com/projects/492774125441/locations/global/workloadIdentityPools/dev-alc25-wip/attribute.repository/kadzielas/Terraform-GCP"
  ]

  service_accounts_roles = flatten([
    for name, roles in module.sa.accounts_project_roles : [
      for role in roles : {
        role  = role
        email = module.sa.service_account_emails[name]
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
