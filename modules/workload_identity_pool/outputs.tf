output "name" {
  description = "The name of the workload identity pool."
  value       = google_iam_workload_identity_pool.pool.name
}

output "workload_identity_pool_id" {
  description = "The ID of the workload identity pool."
  value       = google_iam_workload_identity_pool.pool.workload_identity_pool_id
}

output "workload_identity_pool_provider_id" {
  description = "The ID of the workload identity pool provider."
  value = {
    for provider in google_iam_workload_identity_pool_provider.oidc : provider.workload_identity_pool_provider_id => provider.workload_identity_pool_provider_id
  }
}
