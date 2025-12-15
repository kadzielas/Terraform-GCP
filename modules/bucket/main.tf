resource "google_storage_bucket" "bucket" {
  project  = var.project_id
  name     = var.name
  location = var.region
  labels   = var.labels

  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy

  hierarchical_namespace {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 3
    }
  }
}
