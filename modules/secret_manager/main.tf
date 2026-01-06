resource "google_secret_manager_secret" "secret" {
  for_each = {
    for secret in var.secrets : secret.name => secret
  }

  project   = var.project_id
  secret_id = each.value.name
  labels    = var.labels

  deletion_protection = var.deletion_protection

  replication {
    user_managed {
      dynamic "replicas" {
        for_each = var.replications
        content {
          location = replicas.value.location

          dynamic "cme" {
            for_each = replicas.value.kms_key_name != null ? [1] : [0]
            content {
              kms_key_name = replicas.value.kms_key_name
            }
          }
        }
      }
    }
  }
}
