variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "accounts" {
  description = "Map of service accounts to create."
  type = map(object({
    display_name = string
    roles        = optional(list(string), [])
    sa_bindings = optional(list(object({
      role    = string
      members = list(string)
    })), [])
  }))
  default = {}
}
