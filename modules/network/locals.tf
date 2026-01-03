locals {
  subnets = {
    for x in var.subnets :
    "${x.subnet_region}/${x.subnet_name}" => x
  }
  rules = {
    for x in var.rules :
    "${x.direction}" => x
  }
}
