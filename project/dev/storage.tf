module "bucket" {
  source = "../../modules/bucket"

  project_id                  = var.project_id
  name                        = "${local.prefix}gcs-bucket"
  region                      = var.region
  labels                      = local.labels
  public_access_prevention    = "enforced"
  storage_class               = "REGIONAL"
  uniform_bucket_level_access = true
  force_destroy               = true
}
