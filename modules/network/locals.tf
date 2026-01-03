locals {
  subnets = { for x in var.subnets : x.key => x }
  rules = {
    for x in var.rules :
    "${x.direction}" => x
  }
}
