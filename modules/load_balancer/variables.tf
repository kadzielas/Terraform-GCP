variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
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

variable "name" {
  description = ""
  type        = string
}

variable "ip_address" {
  description = ""
  type        = string
}

variable "network" {
  description = ""
  type        = string
}

variable "subnetwork" {
  description = ""
  type        = string
}

variable "backend_services" {
  description = ""
  type = list(object({
    name                             = string
    timeout_sec                      = optional(number, 20)
    health_check_path                = optional(string, "/")
    health_check_type                = optional(string, "HTTP")
    health_check_timeout_sec         = optional(number, 5)
    health_check_interval_sec        = optional(number, 5)
    health_check_healthy_threshold   = optional(number, 3)
    health_check_unhealthy_threshold = optional(number, 3)
    enable_logging                   = optional(bool, false)
    session_affinity                 = optional(string, "NONE")
    affinity_cookie_ttl_sec          = optional(number, 0)
    cloud_armor_rules = optional(list(object({
      priority    = number
      action      = string
      description = optional(string)
      preview     = optional(bool, false)
      match = optional(object({
        versioned_expr = optional(string)
        config = optional(object({
          src_ip_ranges = optional(list(string), [])
        }))
        expr = optional(object({
          expression = string
        }))
      }))
      preconfigured_waf = optional(object({
        rule_id          = string
        sensitivity      = optional(number)
        opt_out_rule_ids = optional(list(string), [])
      }))
      rate_limit_options = optional(object({
        conform_action                    = string
        exceed_action                     = string
        enforce_on_key                    = optional(string)
        rate_limit_threshold_count        = optional(number)
        rate_limit_threshold_interval_sec = optional(number)
      }))
    })), [])
    negs = list(object({
      name                  = string
      zone                  = string
      balancing_mode        = string
      max_rate_per_endpoint = number
      capacity_scaler       = optional(number, 1.0)
    }))
  }))
}

variable "https_url_map" {
  description = ""
  type = object({
    default_service             = string
    default_error_response_cose = optional(string, "503")
    path_matcher = optional(object({
      name            = optional(string)
      hosts           = optional(list(string), ["*"])
      default_service = string
      path_rules = list(object({
        paths   = set(string)
        service = string
        url_rewrite = optional(object({
          path_prefix_rewrite = optional(string)
          host_rewrite        = optional(string)
        }))
      }))
    }))
  })
}

variable "ssl_certificate" {
  description = ""
  type        = string
  sensitive   = true
}

variable "ssl_private_key" {
  description = ""
  type        = string
  sensitive   = true
}

variable "cloud_armor_shared_rules" {
  description = ""
  type = list(object({
    priority    = number
    action      = string
    description = optional(string)
    preview     = optional(bool, false)
    match = optional(object({
      versioned_expr = optional(string)
      config = optional(object({
        src_ip_ranges = optional(list(string), [])
      }))
      expr = optional(object({
        expression = string
      }))
    }))
    preconfigured_waf = optional(object({
      rule_id          = string
      sensitivity      = optional(number)
      opt_out_rule_ids = optional(list(string), [])
    }))
    rate_limit_options = optional(object({
      conform_action                    = string
      exceed_action                     = string
      enforce_on_key                    = optional(string)
      rate_limit_threshold_count        = optional(number)
      rate_limit_threshold_interval_sec = optional(number)
    }))
  }))
  default = []
}

variable "cloud_armor_verbose_log_level" {
  description = ""
  type        = bool
  default     = false
}
