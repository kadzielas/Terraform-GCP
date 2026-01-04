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
  default     = "europe-central2-a"
}

variable "labels" {
  description = "Resource labels for filtering and billing."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Resource tags for filtering and billing."
  type        = set(string)
  default     = []
}

variable "encryption_key_name" {
  description = "The KMS key name for instance encryption."
  type        = string
  default     = ""
}

variable "kms_sa_email" {
  description = "The service account email used to access the KMS key."
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

variable "auto_delete" {
  description = "Whether the boot disk should be auto-deleted."
  type        = bool
  default     = true
}

variable "interface" {
  description = "The interface type for the boot disk."
  type        = string
  default     = "SCSI"
}

variable "mode" {
  description = "The mode for the boot disk."
  type        = string
  default     = "READ_WRITE"
}

variable "initialize_params" {
  description = "List of maps of additional disks."
  type = object({
    image  = optional(string)
    size   = optional(number)
    type   = optional(string)
    labels = optional(map(string))
  })
  default = {}
}

variable "network_interface" {
  description = ""
  type = object({
    network                     = string
    subnet                      = string
    subnetwork_project          = optional(string)
    associated_ip               = optional(string)
    queue_count                 = optional(number)
    stack_type                  = optional(string)
    internal_ipv6_prefix_length = optional(number)
    access_config = optional(list(object({
      nat_ip = optional(string)
    })))
  })
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
