//*************************
//Pool variables
//*************************

variable "workload_identity_pool_id" {
  description = "ID of the workload identity pool."
  type        = string
  default     = ""
}

variable "display_name" {
  description = "Display name of the workload identity pool provider."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the workload identity pool provider."
  type        = string
  default     = ""
}

variable "disabled" {
  description = "Whether the provider is disabled."
  type        = bool
  default     = true
}

//*************************
//Provider variables
//*************************

variable "oidc_providers" {
  description = "Map of OIDC providers configuration"
  type = map(object({
    display_name        = string
    description         = string
    disabled            = bool
    attribute_condition = optional(string)
    attribute_mapping   = map(string)
    oidc_issuer_uri     = string
    allowed_audiences   = optional(list(string))
  }))
}
