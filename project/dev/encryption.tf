module "encryption" {
  source = "../../modules/encryption"

  project_id = var.project_id
  name       = "${local.prefix}keyring"
  region     = var.region

  cmek_name = "${local.prefix}cmek"
  labels    = local.labels
}
