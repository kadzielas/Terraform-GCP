output "kms" {
  value = google_kms_key_ring.keyring
}

output "kms_id" {
  value = google_kms_key_ring.keyring.id
}

output "cmek" {
  value = google_kms_crypto_key.cmek
}

output "cmek_name" {
  value = google_kms_crypto_key.cmek.name
}
