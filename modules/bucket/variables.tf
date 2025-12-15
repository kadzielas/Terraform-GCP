variable "project_id" {
  type        = string
  description = "The ID of the project in which the resource belongs."
}

variable "name" {
  type        = string
  default     = ""
  description = "description"
}

variable "region" {
  type        = string
  default     = "europe-central2"
  description = "description"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "description"
}

variable "uniform_bucket_level_access" {
  type        = bool
  default     = true
  description = "description"
}

variable "public_access_prevention" {
  type        = string
  default     = "enforced"
  description = "description"
}

variable "storage_class" {
  type        = string
  default     = "STANDARD"
  description = "description"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "description"
}
