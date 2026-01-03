output "service_accounts" {
  value = google_service_account.sa
}

output "service_account_emails" {
  value = {
    for name, sa in google_service_account.sa : name => sa.email
  }
}

output "accounts_project_roles" {
  value = {
    for name, account in var.accounts : name => account.project_roles
  }
}
