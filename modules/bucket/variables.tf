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

variable "uniform_bucket_level_access" {
  description = "description"
  type        = bool
  default     = true
}

variable "public_access_prevention" {
  description = "description"
  type        = string
  default     = "enforced"
}

variable "storage_class" {
  description = "description"
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "description"
  type        = bool
  default     = false
}
