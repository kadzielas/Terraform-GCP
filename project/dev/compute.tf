resource "google_compute_address" "static_ip" {
  name   = "my-vm-static-ip"
  region = var.region
}

module "vm" {
  source = "../../modules/compute"

  project_id = var.project_id
  zone       = "${var.region}-a"
  labels     = local.labels

  kms_sa_email        = module.sa.service_account_emails["${local.prefix}sa-compute"]
  encryption_key_name = module.encryption.cmek_name

  name         = "${local.prefix}vm-main"
  machine_type = "n2-standard-4"


  network_interface = {
    network                     = module.network.network_self_link
    subnet                      = module.network.subnets["warsaw"].self_link
    subnetwork_project          = var.project_id
    associated_ip               = "10.0.0.5"
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    internal_ipv6_prefix_length = 0
    access_config = [
      {
        nat_ip = google_compute_address.static_ip.address
      }
    ]
  }
  tags = ["dev", "europe", "warsaw"]

  auto_delete = true
  mode        = "READ_WRITE"

  initialize_params = {
    auto_delete = true
    device_name = "${local.prefix}vm-disk-main"
    interface   = "SCSI"
    image       = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-stream-10-v20251111"
    size        = 50
    type        = "pd-ssd"
    labels      = local.labels
  }



  service_account_email  = module.sa.service_account_emails["${local.prefix}sa-compute"]
  service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  depends_on = [module.network]
}
