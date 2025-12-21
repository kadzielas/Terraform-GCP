variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "name" {
  description = "description"
  type        = string
  default     = ""
}

variable "region" {
  description = "description"
  type        = string
  default     = "europe-central2"
}

variable "labels" {
  description = "description"
  type        = map(string)
  default     = {}
}

variable "database_version" {
  description = ""
  type = 
  default = 
}

variable "maintenance_version" {
  description = ""
  type = 
  default = 
}

variable "encryption_key_name" {
  description = ""
  type = 
  default = 
}

variable "deletion_protection" {
  description = ""
  type = 
  default = 
}

variable "root_password" {
  description = ""
  type = 
  default = 
}

variable "instance_type" {
  description = ""
  type = 
  default = 
}

variable "tier" {
  description = ""
  type = 
  default = 
}

variable "edition" {
  description = ""
  type = 
  default = 
}

variable "activation_policy" {
  description = ""
  type = 
  default = 
}

variable "availability_type" {
  description = ""
  type = 
  default = 
}

variable "deletion_protection_enabled" {
  description = ""
  type = 
  default = 
}

variable "retain_backups_on_delete" {
  description = ""
  type = 
  default = 
}

variable "backup_configuration" {
  description = ""
  type = object({
    backups_enabled                        = optional(bool, false)
    start_time                     = optional(string)
    location                       = optional(string)
    point_in_time_recovery_enabled = optional(bool, false)
    transaction_log_retention_days = optional(string)
    retained_backups               = optional(number)
    retention_unit                 = optional(string)
  })
  default = {}
}

variable "ip_configuration" {
  description = ""
  type = object({
    authorized_networks                           = optional(list(map(string)), [])
    ipv4_enabled                                  = optional(bool, true)
    private_network                               = optional(string)
    ssl_mode                                      = optional(string)
    allocated_ip_range                            = optional(string)
    enable_private_path_for_google_cloud_services = optional(bool, false)
    psc_enabled                                   = optional(bool, false)
    psc_allowed_consumer_projects                 = optional(list(string), [])
    server_ca_mode                                = optional(string)
    server_ca_pool                                = optional(string)
  })
  default = {}
}