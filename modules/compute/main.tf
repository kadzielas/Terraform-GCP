resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  instance_encryption_key {
    kms_key_self_link       = var.encryption_key_name
    kms_key_service_account = var.service_account_email
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet
  }

  boot_disk {
    auto_delete = var.auto_delete
    interface   = var.interface
    mode        = var.mode

    initialize_params {
      image  = var.initialize_params.image
      size   = var.initialize_params.size
      type   = var.initialize_params.type
      labels = var.initialize_params.labels
    }
  }

  # scratch_disk {
  #   interface = "NVME"
  # }

  tags = var.tags

  metadata = var.metadata

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
}

