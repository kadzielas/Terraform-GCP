variable "project_id" {
  description = "ID of project"
  type        = string
  default     = "daring-chess-474306-h4"
}

variable "project_number" {
  description = "Number of project"
  type        = string
  default     = "432432634"
}

variable "location" {
  description = "GCP location"
  type        = string
  default     = "EU"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-central2"
}

variable "project_iam" {
  description = "Map of IAM roles"
  type        = map(list(string))
  default     = {}
}

variable "secret_managers" {
  description = "List of managers with access to secrets"
  type        = list(string)
  default     = []
}
