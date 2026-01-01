output "self_link_unique" {
  description = "Unique self-link of instance template."
  value       = google_compute_instance_template.tpl.self_link_unique
}

output "self_link" {
  description = "Self-link of instance template."
  value       = google_compute_instance_template.tpl.self_link
}
