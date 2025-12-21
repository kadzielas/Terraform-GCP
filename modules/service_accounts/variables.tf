variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "accounts" {
  description = "Map of service accounts to create."
  type = map(object({
    account_id           = optional(string)
    display_name         = optional(string)
    roles                = optional(list(string))
    is_workload_identity = optional(bool)
  }))
  default = {}
}
