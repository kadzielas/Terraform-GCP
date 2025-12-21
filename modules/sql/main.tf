resource "google_sql_database_instance" "main" {
  project             = var.project_id
  region              = var.region
  name                = var.name
  database_version    = var.database_version
  maintenance_version = var.maintenance_version
  encryption_key_name = var.encryption_key_name
  deletion_protection = var.deletion_protection
  root_password       = var.root_password
  instance_type       = var.instance_type

  settings {
    tier                        = var.tier
    edition                     = var.edition
    activation_policy           = var.activation_policy
    availability_type           = var.availability_type
    deletion_protection_enabled = var.deletion_protection_enabled
    retain_backups_on_delete    = var.retain_backups_on_delete
    user_labels                 = var.labels

    disk_autoresize       = var.disk_autoresize
    disk_autoresize_limit = var.disk_autoresize_limit
    disk_size             = var.disk_size
    disk_type             = var.disk_type
    pricing_plan          = var.pricing_plan

    dynamic "backup_configuration" {
      for_each = var.backup_configuration != null ? 1 : 0
      content {
        enabled                        = lookup(backup_configuration.value, "backups_enabled", false)
        start_time                     = lookup(backup_configuration.value, "start_time", null)
        location                       = lookup(backup_configuration.value, "location", null)
        point_in_time_recovery_enabled = lookup(backup_configuration.value, "point_in_time_recovery_enabled", false)
        transaction_log_retention_days = lookup(backup_configuration.value, "transaction_log_retention_days", null)

        dynamic "backup_retention_settings" {
          for_each = var.backup_configuration.backup_retention_settings != null ? 1 : 0
          content {
            retained_backups = lookup(backup_retention_settings.value, "retained_backups", null)
            retention_unit   = lookup(backup_retention_settings.value, "retention_unit", null)
          }
        }
      }
    }
  }

  dynamic "ip_configuration" {
    for_each = var.ip_configuration != null ? 1 : 0
    content {
      ipv4_enabled                                  = lookup(ip_configuration.value, "ipv4_enabled", null)
      private_network                               = lookup(ip_configuration.value, "private_network", null)
      ssl_mode                                      = lookup(ip_configuration.value, "ssl_mode", null)
      allocated_ip_range                            = lookup(ip_configuration.value, "allocated_ip_range", null)
      enable_private_path_for_google_cloud_services = lookup(ip_configuration.value, "enable_private_path_for_google_cloud_services", false)
      server_ca_mode                                = lookup(ip_configuration.value, "server_ca_mode", null)
      server_ca_pool                                = lookup(ip_configuration.value, "server_ca_pool", null)

      dynamic "authorized_networks" {
        for_each = var.ip_configuration.authorized_networks != null ? 1 : 0
        content {
          expiration_time = lookup(authorized_networks.value, "expiration_time", null)
          name            = lookup(authorized_networks.value, "name", null)
          value           = lookup(authorized_networks.value, "value", null)
        }
      }

      dynamic "psc_config" {
        for_each = var.ip_configuration.psc_config != null ? 1 : 0
        content {
          psc_enabled               = ip_configuration.value.psc_enabled
          allowed_consumer_projects = ip_configuration.value.psc_allowed_consumer_projects
        }
      }
    }
  }

  dynamic "database_flags" {
    for_each = var.database_flags != null ? 1 : 0
    content {
      name  = lookup(database_flags.value, "name", null)
      value = lookup(database_flags.value, "value", null)
    }
  }

  dynamic "location_preference" {
    for_each = var.zone != null ? 1 : 0
    content {
      zone                   = var.zone
      secondary_zone         = local.is_secondary_instance ? null : var.secondary_zone
      follow_gae_application = local.is_secondary_instance ? null : var.follow_gae_application
    }
  }

  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }
}

resource "null_resource" "module_depends_on" {
  triggers = {
    value = length(var.module_depends_on)
  }
}
