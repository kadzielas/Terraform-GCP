resource "google_sql_database_instance" "replicas" {
  for_each = var.replicas ? var.replicas : {}

  project = var.project_id
  region  = each.value.region

  name                 = each.key
  database_version     = var.database_version
  master_instance_name = google_sql_database_instance.main
  deletion_protection  = var.replica_deletion_protection
  encryption_key_name  = each.value.encryption_key_name

  replica_configuration {
    failover_target = each.value.failover_target
  }

  settings {
    edition                     = each.value.edition
    tier                        = each.value.tier
    activation_policy           = each.value.activation_policy
    availability_type           = each.value.availability_type
    deletion_protection_enabled = var.replica_deletion_protection_enabled
    disk_size                   = each.value.disk_size
    disk_type                   = each.value.disk_type
    disk_autoresize             = each.value.disk_autoresize
    disk_autoresize_limit       = each.value.autoresize_limit
    user_labels                 = var.value.user_labels

    dynamic "ip_configuration" {
      for_each = each.value.ip_configuration ? [each.value.ip_configuration] : []
      content {
        ipv4_enabled                                  = ip_configuration.value.ipv4_enabled
        private_network                               = ip_configuration.value.private_network
        ssl_mode                                      = ip_configuration.value.ssl_mode
        allocated_ip_range                            = ip_configuration.value.allocated_ip_range
        enable_private_path_for_google_cloud_services = ip_configuration.value.enable_private_path_for_google_cloud_services
        server_ca_mode                                = ip_configuration.value.server_ca_mode
        server_ca_pool                                = ip_configuration.value.server_ca_pool
      }
    }

    dynamic "insights_config" {
      for_each = each.value.insights_config ? [each.value.insights_config] : []

      content {
        query_insights_enabled  = insights_config.value.query_insights_enabled
        query_plans_per_minute  = insights_config.value.query_plans_per_minute
        query_string_length     = insights_config.value.query_string_length
        record_application_tags = insights_config.value.record_application_tags
        record_client_address   = insights_config.value.record_client_address
      }
    }
  }
  dynamic "database_flags" {
    for_each = lookup(each.value, "database_flags", [])
    content {
      name  = lookup(database_flags.value, "name", null)
      value = lookup(database_flags.value, "value", null)
    }
  }

  depends_on = [google_sql_database_instance.main]
}
