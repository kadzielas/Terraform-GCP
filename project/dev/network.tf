module "network" {
  source = "../../modules/network"

  project_id = var.project_id
  region     = var.region

  # vpc
  vpc_name     = "${local.prefix}vpc"
  routing_mode = "REGIONAL"

  # subnets
  subnets = [
    {
      key                   = "warsaw"
      subnet_name           = "${local.prefix}subnet-warsaw"
      subnet_ip             = "10.0.0.0/27"
      subnet_region         = "europe-central2"
      subnet_private_access = "true"
    },
    {
      key                   = "frankfurt"
      subnet_name           = "${local.prefix}subnet-frankfurt"
      subnet_ip             = "20.0.0.0/27"
      subnet_region         = "europe-west3"
      subnet_private_access = "true"

    },
    {
      key                   = "oregon"
      subnet_name           = "${local.prefix}subnet-oregon"
      subnet_ip             = "30.0.0.0/27"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
    }
  ]
  private_service_connect_name = "${local.prefix}psc-all-apis"
  private_service_connect_ip   = "10.0.0.255"
  forwarding_rule_target       = "all-apis"

  #firewall
  rules = [
    {
      name          = "${local.prefix}allow-tcp-ingress"
      direction     = "INGRESS"
      priority      = 100
      action        = "ALLOW"
      protocol      = "tcp"
      ports         = ["22", "80", "443"]
      source_ranges = ["35.235.240.0/20"]
    },
    {
      name        = "${local.prefix}allow-icmp-ingress"
      direction   = "INGRESS"
      priority    = 100
      action      = "ALLOW"
      protocol    = "icmp"
      source_tags = ["dev"]
    }
  ]

  depends_on = [module.project]
}
