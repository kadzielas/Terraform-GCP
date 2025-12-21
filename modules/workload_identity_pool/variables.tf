variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "name" {
  description = "Unique name for the SQL instance."
  type        = string
  default     = ""
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

variable "workload_identity_pool_id" {
  description = "ID for the Workload Identity Pool."
  type        = string
  default     = ""
}

variable "display_name" {
  description = "Display name for the Workload Identity Pool."
  type        = string
  default     = ""
}

variable "description" {
  description = ""
  type        = string
  default     = ""
}

variable "disabled" {
  description = ""
  type        = bool
  default     = false
}

variable "provider_workload_identity_pool_id" {
  description = "ID for the Workload Identity Pool."
  type        = string
  default     = ""
}

variable "provider_display_name" {
  description = "Display name for the Workload Identity Pool."
  type        = string
  default     = ""
}

variable "provider_description" {
  description = ""
  type        = string
  default     = ""
}

variable "provider_disabled" {
  description = ""
  type        = bool
  default     = false
}
