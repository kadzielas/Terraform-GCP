module "vm" {
  source = "../../modules/compute"

  project_id = var.project_id
  zone       = var.region

  name         = "${local.prefix}vm-main"
  machine_type = "e2-standard-4"

  boot_disk = {
    auto_delete = true
    mode        = "READ_WRITE"
    initialize_params = {
      image  = "rhel-10-v202512091"
      size   = 20
      type   = "pd-ssd"
      labels = local.labels
    }
  }

  network_interface = {
    network    = module.network.network_id
    subnetwork = module.network.subnets["${local.prefix}subnet-warsaw"].id
  }

  service_account_email  = module.sa.service_account_emails["${local.prefix}sa-compute"]
  service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

}
