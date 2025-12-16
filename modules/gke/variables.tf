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
