resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  instance_encryption_key {
    kms_key_self_link       = var.encryption_key_name
    kms_key_service_account = var.service_account_email
  }

  dynamic "boot_disk" {
    for_each = var.boot_disk != null ? [1] : [0]
    content {
      auto_delete = lookup(boot_disk.value, "auto_delete", true)
      interface   = lookup(boot_disk.value, "interface", null)
      mode        = lookup(boot_disk.value, "mode", null)
      source      = lookup(boot_disk.value, "source", null)
      dynamic "initialize_params" {
        for_each = boot_disk.value.initialize_params
        content {
          image  = lookup(initialize_params.value, "image", null)
          size   = lookup(initialize_params.value, "size", null)
          type   = lookup(initialize_params.value, "type", null)
          labels = lookup(initialize_params.value, "labels", null)
        }
      }
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface != null ? [1] : [0]

    content {
      network            = lookup(network_interface.value, "network")
      subnetwork         = lookup(network_interface.value, "subnetwork")
      subnetwork_project = lookup(network_interface.value, "subnetwork_project")
      dynamic "access_config" {
        for_each = network_interface.value.access_config != null ? [1] : [0]
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.network_tier
        }
      }
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  tags = var.tags

  metadata = var.metadata

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
}

