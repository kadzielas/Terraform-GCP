output "id" {
  description = "Unique self-link of instance."
  value       = google_compute_instance.default.id
}

output "self_link" {
  description = "Self-link of instance."
  value       = google_compute_instance.default.self_link
}
