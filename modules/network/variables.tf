####################################
# General Variables
####################################

variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "region" {
  description = "GCP region for resource deployment."
  type        = string
  default     = "europe-central2"
}

variable "labels" {
  description = "Resource labels for filtering and billing."
  type        = map(string)
  default     = {}
}

####################################
# VPC Network Variables
####################################

variable "vpc_name" {
  description = "The name of the network being created"
  type        = string
  default     = ""
}

variable "routing_mode" {
  type        = string
  description = "The network routing mode (default 'GLOBAL')"
  default     = "GLOBAL"
}

####################################
# Subnet Variables
####################################

variable "subnets" {
  description = "The list of subnets being created"
  type = list(object({
    key                   = string
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = optional(string)
    purpose               = optional(string)
  }))
  default = []
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}

####################################
# Firewall Variables
####################################

variable "rules" {
  description = "This is DEPRECATED and available for backward compatibility. Use ingress_rules and egress_rules variables. List of custom rule definitions"
  type = list(object({
    name                    = string
    direction               = optional(string, "INGRESS")
    disabled                = optional(bool, null)
    priority                = optional(number, null)
    ranges                  = optional(list(string))
    source_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    protocol                = optional(string)
    ports                   = optional(list(string))
  }))
  default = []

}
