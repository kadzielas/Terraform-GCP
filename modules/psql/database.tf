resource "google_sql_database" "database" {
  for_each = var.databases

  project = var.project_id

  name      = each.key
  instance  = google_sql_database_instance.main.name
  charset   = each.value.charset
  collation = each.value.collation

  deletion_policy = each.value.deletion_policy

  depends_on = [terraform_data.module_depends_on]

  lifecycle {
    prevent_destroy      = false
    replace_triggered_by = [google_sql_database_instance.main.id]
  }
}

resource "google_sql_user" "users" {
  for_each = var.users

  project = var.project_id

  name     = each.value
  instance = google_sql_database_instance.main.name
  password = var.user_passwords[each.key]
  type     = var.user_types[each.key]

  deletion_policy = each.value.deletion_policy

  dynamic "password_policy" {
    for_each = each.value.password_policy != null ? [each.value.password_policy] : []
    content {
      allowed_failed_attempts      = password_policy.value.allowed_failed_attempts
      password_expiration_duration = password_policy.value.password_expiration_duration
      enable_failed_attempts_check = password_policy.value.enable_failed_attempts_check
      enable_password_verification = password_policy.value.enable_password_verification
    }
  }

  depends_on = [terraform_data.module_depends_on]

  lifecycle {
    prevent_destroy      = false
    replace_triggered_by = [google_sql_database_instance.main.id]
  }
}
