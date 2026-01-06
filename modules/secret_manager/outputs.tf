output "secrets" {
  description = "Map of secrets."
  value       = google_secret_manager_secret.secret
}
