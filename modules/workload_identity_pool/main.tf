resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.display_name
  description               = var.description
  disabled                  = var.disabled
}

resource "google_iam_workload_identity_pool_provider" "oidc" {
  for_each = var.oidc_providers

  workload_identity_pool_id          = var.workload_identity_pool_id
  workload_identity_pool_provider_id = each.key
  display_name                       = each.value.display_name
  description                        = each.value.description
  disabled                           = each.value.disabled
  attribute_condition                = each.value.attribute_condition
  attribute_mapping                  = each.value.attribute_mapping

  oidc {
    issuer_uri        = each.value.oidc_issuer_uri
    allowed_audiences = each.value.allowed_audiences
  }

  depends_on = [google_iam_workload_identity_pool.pool]
}
