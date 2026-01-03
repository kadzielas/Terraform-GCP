resource "google_service_account" "sa" {
  for_each = var.accounts

  project      = var.project_id
  account_id   = each.key
  display_name = each.value.display_name
}

resource "google_service_account_iam_binding" "sa_iam" {
  for_each = local.sa_bindings

  service_account_id = google_service_account.sa[each.value.account_name].name
  role               = each.value.role
  members            = each.value.members
}
