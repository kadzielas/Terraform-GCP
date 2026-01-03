variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "name" {
  description = "Unique name for the SQL instance."
  type        = string
  default     = ""
}

variable "zone" {
  description = "GCP zone for resource deployment."
  type        = string
  default     = "europe-central2"
}

variable "tags" {
  description = "Resource labels for filtering and billing."
  type        = set(string)
  default     = []
}

variable "encryption_key_name" {
  description = "The KMS key name for instance encryption."
  type        = string
  default     = ""
}

variable "metadata" {
  description = "Metadata to attach to the compute instance."
  type        = map(string)
  default     = {}
}

variable "machine_type" {
  description = "The machine type to create."
  type        = string
  default     = "e2-medium"
}

variable "boot_disk" {
  description = "List of maps of additional disks."
  type = object({
    auto_delete = optional(bool)
    device_name = optional(string)
    interface   = optional(string)
    mode        = optional(string)
    source      = optional(string)
    initialize_params = optional(object({
      image  = optional(string)
      size   = optional(number)
      type   = optional(string)
      labels = optional(map(string))
    }))
  })
  default = {}
}
variable "network_interface" {
  description = "Additional network interface details for GCE, if any."
  type = map(object({
    network            = optional(string)
    subnetwork         = optional(string)
    subnetwork_project = optional(string)
    network_ip         = optional(string)
    nic_type           = optional(string)
    stack_type         = optional(string)
    queue_count        = optional(number)
    access_config = optional(object({
      nat_ip       = optional(string)
      network_tier = optional(string)
    }))
    ipv6_access_config = optional(object({
      network_tier = optional(string)
    }))
    alias_ip_range = optional(object({
      ip_cidr_range         = optional(string)
      subnetwork_range_name = optional(string)
    }))
  }))
  default = {}

}

variable "service_account_email" {
  description = "The service account email to attach to the compute instance."
  type        = string
  default     = ""
}

variable "service_account_scopes" {
  description = "The service account scopes to attach to the compute instance."
  type        = list(string)
  default     = ["cloud-platform"]
}
