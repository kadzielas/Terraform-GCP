variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "accounts" {
  description = "Map of service accounts to create."
  type = map(object({
    display_name         = optional(string)
    roles                = optional(list(string))
    is_workload_identity = optional(bool)
  }))
  default = {}
}
