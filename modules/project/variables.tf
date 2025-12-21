variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "services" {
  description = "The API service to enable for the project."
  type        = list(string)
}

variable "disable_on_destroy" {
  description = "Whether to disable the service when the resource is destroyed."
  type        = bool
  default     = false
}

variable "disable_dependent_services" {
  description = "Whether to disable dependent services when disabling this service."
  type        = bool
  default     = false
}
