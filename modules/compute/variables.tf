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
  default     = {}
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

variable "boot_image" {
  description = "The boot image for the compute instance."
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk" {
  description = "List of maps of additional disks."
  type = list(object({
    auto_delete     = optional(bool, true)
    boot            = optional(bool, false)
    device_name     = optional(string)
    disk_name       = optional(string)
    disk_size_gb    = optional(number)
    disk_type       = optional(string)
    disk_labels     = optional(map(string), {})
    interface       = optional(string)
    mode            = optional(string)
    source          = optional(string)
    source_image    = optional(string)
    source_snapshot = optional(string)
  }))
  default = []
}
variable "network" {
  description = "Additional network interface details for GCE, if any."
  default     = []
  type = list(object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
    network_ip         = string
    nic_type           = string
    stack_type         = string
    queue_count        = number
    access_config = list(object({
      nat_ip       = string
      network_tier = string
    }))
    ipv6_access_config = list(object({
      network_tier = string
    }))
    alias_ip_range = list(object({
      ip_cidr_range         = string
      subnetwork_range_name = string
    }))
  }))
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
