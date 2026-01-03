module "network" {
  source = "../../modules/network"

  project_id = var.project_id
  region     = var.region

  # vpc
  vpc_name     = "${local.prefix}vpc"
  routing_mode = "GLOBAL"

  # subnets
  subnets = [
    {
      subnet_name           = "${local.prefix}subnet-warsaw"
      subnet_ip             = "10.0.0.0/27"
      subnet_region         = "europe-central2"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "${local.prefix}subnet-frankfurt"
      subnet_ip             = "20.0.0.0/27"
      subnet_region         = "europe-west3"
      subnet_private_access = "true"

    },
    {
      subnet_name           = "${local.prefix}subnet-us"
      subnet_ip             = "30.0.0.0/27"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
    }
  ]

  # firewall
  rules = [
    {
      name          = "default-allow-ingress"
      direction     = "INGRESS"
      priority      = 1000
      action        = "ALLOW"
      protocols     = "tcp"
      ports         = ["22"]
      source_ranges = ["0.0.0.0/0"]
    }
  ]
}
