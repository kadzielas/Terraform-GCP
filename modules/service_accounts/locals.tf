locals {
  role_to_members = {
    for role in distinct(flatten([
      for name, account in var.accounts : account.project_roles
      ])) : role => [
      for name, account in var.accounts : "serviceAccount:${google_service_account.sa[name].email}"
      if contains(account.project_roles, role)
    ]
  }

  sa_bindings = {
    for item in flatten([
      for name, account in var.accounts : [
        for idx, binding in try(account.iam_bindings, []) : {
          key          = "${name}_${binding.role}_${idx}"
          account_name = name
          role         = binding.role
          members      = binding.members
        }
      ]
    ]) : item.key => item
  }
}
