####################################
# General Variables
####################################

variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "labels" {
  description = "Resource labels for filtering and billing."
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      contains(keys(var.labels), "environment")
    ])
    error_message = "Environment must be defined."
  }
}

####################################
# Secret Manager Variables
####################################

variable "replications" {
  description = "List of replication locations."
  type = list(object({
    location  = string
    accessors = list(string)
  }))
  default = []
}

variable "secrets" {
  description = "List of secrets."
  type = list(object({
    type      = bool
    accessors = list(string)
  }))
  default = []
}

variable "deletion_protection" {
  description = "Option to use deletion protection."
  type        = bool
  default     = false
}

variable "managers" {
  description = "List of users with managers privilages."
  type        = set(string)
  default     = []
}
