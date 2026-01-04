module "vm" {
  source = "../../modules/compute"

  project_id = var.project_id
  zone       = "${var.region}-a"

  name         = "${local.prefix}vm-main"
  machine_type = "n2-standard-4"


  network_interface = {
    network                     = module.network.network_id
    subnet                      = module.network.subnets["warsaw"].id
    subnetwork_project          = var.project_id
    associated_ip               = "10.0.0.5"
    queue_count                 = 0
    stack_type                  = "IPV4_ONLY"
    internal_ipv6_prefix_length = 0
  }

  auto_delete = true
  mode        = "READ_WRITE"

  initialize_params = {
    auto_delete = true
    device_name = "${local.prefix}vm-disk-main"
    interface   = "SCSI"
    image       = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-stream-10-v20251111 "
    size        = 50
    type        = "pd-ssd"
    labels      = local.labels
  }

  tags = ["dev"]

  service_account_email  = module.sa.service_account_emails["${local.prefix}sa-compute"]
  service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  depends_on = [module.network]
}
