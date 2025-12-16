resource "google_service_account" "service_account" {
  for_each = var.accounts

  project = var.project_id

  account_id   = each.key
  display_name = try(each.value.display_name, each.key)
}

resource "google_project_iam_binding" "project_iam_binding" {
  for_each = local.roles

  project = var.project_id
  role    = each.key
  members = each.value

  depends_on = [google_service_account.service_account]
}

# resource "google_service_account_iam_binding" "workload_identity" {
#   for_each = { for k, v in var.accounts : k => v if v.is_workload_identity == true }

#   service_account_id = google_service_account.service_account[each.key].name
#   role               = "roles/iam.workloadIdentityUser"
#   members = [
#     "serviceAccount:${var.project_id}.svc.id.goog[${each.key}/*]"
#   ]

#   depends_on = [google_service_account.service_account]
# }
