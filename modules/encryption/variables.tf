variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "name" {
  description = "Unique name for the KMS."
  type        = string
  default     = ""
}

variable "cmek_name" {
  description = "Unique name for the CMEK."
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
