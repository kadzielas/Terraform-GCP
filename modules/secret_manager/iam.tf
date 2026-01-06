resource "google_secret_manager_secret_iam_binding" "iam_version_manager" {
  for_each = length(var.managers) > 0 ? google_secret_manager_secret.secret : {}

  secret_id = each.value.id
  role      = "roles/secretmanager.secretVersionManager"
  members   = var.managers

  depends_on = [google_secret_manager_secret.secret]
}

resource "google_secret_manager_secret_iam_binding" "iam_version_manager" {
  for_each = {
    for secret in var.secrets : secret.name => secret
    if length(secret.accessors) > 0
  }

  secret_id = google_secret_manager_secret.secret[each.value.name].id
  role      = "roles/secretmanager.secretAccessor"
  members   = distinct(contact(each.value.accessors, var.managers))

  depends_on = [google_secret_manager_secret.secret]
}
