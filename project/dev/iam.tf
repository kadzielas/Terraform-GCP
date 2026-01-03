resource "google_project_iam_binding" "project" {
  for_each = local.all_project_iam

  project = var.project_id
  role    = each.key
  members = each.value
}
