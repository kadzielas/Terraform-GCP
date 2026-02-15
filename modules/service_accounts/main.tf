resource "google_service_account" "sa" {
  for_each = var.accounts

  project      = var.project_id
  account_id   = each.key
  display_name = each.value.display_name
}

resource "google_service_account_iam_binding" "sa_iam" {
  for_each = local.sa_bindings

  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value.account_name}@${var.project_id}.iam.gserviceaccount.com"
  role               = each.value.role
  members            = each.value.members

  depends_on = [google_service_account.sa]
}

resource "google_project_iam_binding" "roles" {
  for_each = local.role_to_members

  project = var.project_id
  role    = each.key
  members = each.value

  depends_on = [google_service_account.sa]
}
