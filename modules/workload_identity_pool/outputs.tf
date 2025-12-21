output "workload_pool_provider_id" {
  description = "Workload pool provider used by confidential space."
  value       = google_iam_workload_identity_pool_provider.attestation_verifier.workload_identity_pool_provider_id
}

output "workload_identity_pool_id" {
  description = "Workload identity pool ID."
  value       = google_iam_workload_identity_pool.confidential_space_pool.workload_identity_pool_id
}
