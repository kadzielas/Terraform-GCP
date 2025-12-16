locals {
  roles = {
    for role in distinct(
      flatten(
        [
          for sa in var.accounts : sa.roles
        ]
      )
      ) : role => [
      for key, sa in var.accounts : "serviceAccount:${google_service_account.service_account[key].email}"
    ]
  }
}
