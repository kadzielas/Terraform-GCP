resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  enable_display = false
  labels         = var.labels

  resource_policies = []

  instance_encryption_key {
    kms_key_self_link       = var.encryption_key_name
    kms_key_service_account = "dev-alc25-sa-compute@daring-chess-474306-h4.iam.gserviceaccount.com"
  }

  dynamic "network_interface" {
    for_each = var.network_interface != null ? [0] : []
    content {
      network                     = var.network_interface.network
      subnetwork                  = var.network_interface.subnet
      subnetwork_project          = var.network_interface.subnetwork_project
      network_ip                  = var.network_interface.associated_ip
      queue_count                 = var.network_interface.queue_count
      stack_type                  = var.network_interface.stack_type
      internal_ipv6_prefix_length = var.network_interface.internal_ipv6_prefix_length
      dynamic "access_config" {
        for_each = try(network_interface.value.access_config, [])
        content {
          nat_ip = try(access_config.value.nat_ip, null)
        }
      }
    }
  }

  boot_disk {
    auto_delete  = var.auto_delete
    interface    = var.interface
    mode         = var.mode
    force_attach = false
    guest_os_features = [
      "UEFI_COMPATIBLE",
      "GVNIC",
      "IDPF",
    ]

    initialize_params {
      architecture                = "X86_64"
      enable_confidential_compute = false
      image                       = var.initialize_params.image
      size                        = var.initialize_params.size
      type                        = var.initialize_params.type
      labels                      = var.initialize_params.labels
      resource_manager_tags       = {}
    }
  }

  scheduling {
    automatic_restart   = true
    availability_domain = 0
    min_node_cpus       = 0
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = var.tags

  metadata = var.metadata

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"],
      instance_encryption_key["kms_key_self_link"],
    ]
  }
}

