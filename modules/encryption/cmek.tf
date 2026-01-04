resource "google_kms_crypto_key" "cmek" {
  name            = var.cmek_name
  key_ring        = google_kms_key_ring.keyring.id
  labels          = var.labels
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = false
  }
}
