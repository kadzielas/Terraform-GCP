locals {
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
  role_to_members = {
    for role in distinct(flatten([
      for sa in var.accounts : sa.roles
      ])) : role => [
      for key, sa in var.accounts : "serviceAccount:${google_service_account.sa[key].email}"
      if contains(sa.roles, role)
    ]
  }
}
