output "instance_name" {
  value       = google_sql_database_instance.default.name
  description = "The instance name for the master instance"
}

output "id" {
  value       = google_sql_database_instance.main.id
  description = "ID of primary instance."
}

output "public_ip_address" {
  value       = google_sql_database_instance.default.public_ip_address
  description = "(PRIMARY) IPv4 address assigned for the master instance"
}

output "private_ip_address" {
  value       = google_sql_database_instance.default.private_ip_address
  description = "(PRIVATE) IPv4 address assigned for the master instance"
}

output "instance_ip_address" {
  value       = google_sql_database_instance.default.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "instance_service_account_email_address" {
  value       = google_sql_database_instance.default.service_account_email_address
  description = "The service account email address assigned to the master instance"
}

output "instance_psc_attachment" {
  value       = google_sql_database_instance.default.psc_service_attachment_link
  description = "The psc_service_attachment_link created for the master instance"
}

output "primary" {
  value       = google_sql_database_instance.default
  description = "The `google_sql_database_instance` resource representing the primary instance"
  sensitive   = true
}

output "databases" {
  value = {
    for name, db in google_sql_database.databases : name => {
      id        = db.id
      name      = db.name
      charset   = db.charset
      collation = db.collation
      self_link = db.self_link
    }
  }
  description = "Database details"
}

output "users" {
  value = {
    for name, user in google_sql_user.users : name => {
      id        = user.id
      name      = user.name
      type      = user.type
      self_link = user.sql_server_user_details
    }
  }
  description = "User details (without passwords)"
}
