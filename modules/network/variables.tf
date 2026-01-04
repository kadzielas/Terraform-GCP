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

variable "dns_code" {
  description = "Code to identify DNS resources in the form of `{dns_code}-{dns_type}`"
  type        = string
  default     = "dz"
}

variable "private_service_connect_name" {
  description = "Private Service Connect endpoint name. Defaults to `global-psconnect-ip`"
  type        = string
  default     = "global-psconnect-ip"
}

variable "private_service_connect_ip" {
  description = "The internal IP to be used for the private service connect."
  type        = string
}

variable "forwarding_rule_name" {
  description = "Forwarding rule resource name. The forwarding rule name for PSC Google APIs must be an 1-20 characters string with lowercase letters and numbers and must start with a letter. Defaults to `globalrule`"
  type        = string
  default     = "globalrule"
}

variable "forwarding_rule_target" {
  description = "Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid."
  type        = string

  validation {
    condition     = var.forwarding_rule_target == "all-apis" || var.forwarding_rule_target == "vpc-sc"
    error_message = "For forwarding_rule_target only `all-apis` and `vpc-sc` are valid."
  }
}

variable "service_directory_namespace" {
  description = "Service Directory namespace to register the forwarding rule under."
  type        = string
  default     = null
}

variable "service_directory_region" {
  description = "Service Directory region to register this global forwarding rule under. Defaults to `us-central1` if not defined."
  type        = string
  default     = null
}

variable "psc_global_access" {
  description = "This is used in PSC consumer ForwardingRule to control whether the PSC endpoint can be accessed from another region. Defaults to `false`"
  type        = bool
  default     = false
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
