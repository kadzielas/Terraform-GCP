locals {
  prefix = "dev-alc25-"
  labels = {
    environment = "dev"
    project     = "sandbox"
    destination = "github"
  }

  services = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "iamcredentials.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-component.googleapis.com",
    "sts.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com"
  ]

  project_iam_bindings = {
    for role in distinct(flatten([
      for member, roles in local.project_iam : roles
      ])) : role => [
      for member, roles in local.project_iam : member
      if contains(roles, role)
    ]
  }

  project_iam = merge(var.project_iam, {
    "serviceAccount:${module.service_accounts.email["${local.prefix}sa-github"]}" = [
      "roles/viewer",
    ]
    }
  )
}
