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
      boot_image  = lookup(boot_disk.value, "boot_image", null)
      auto_delete = lookup(boot_disk.value, "auto_delete", null)
      mode        = lookup(boot_disk.value, "mode", null)
      size        = lookup(boot_disk.value, "size", null)
      type        = lookup(boot_disk.value, "type", null)
      image       = lookup(boot_disk.value, "image", null)
      labels      = lookup(boot_disk.value, "labels", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network != null ? [1] : [0]

    content {
      network            = var.network
      subnetwork         = var.subnetwork
      subnetwork_project = var.subnetwork_project
      network_ip         = length(var.static_ips) == 0 ? "" : element(local.static_ips, count.index)
      dynamic "access_config" {
        for_each = var.access_config
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.network_tier
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
