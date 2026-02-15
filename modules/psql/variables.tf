#----------------------------------------------#
# COMMON VARIABLES
#----------------------------------------------#

variable "project_id" {
  description = "Target GCP project ID for resources."
  type        = string
}

variable "name" {
  description = "Unique name for the SQL instance."
  type        = string
  default     = ""
}

variable "region" {
  description = "GCP region for resource deployment."
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "The zone for the Cloud SQL instance."
  type        = string
  default     = null
}

variable "labels" {
  description = "Resource labels for filtering and billing."
  type        = map(string)
  default     = {}
}

#----------------------------------------------#
# RESOURCE-SPECIFIC VARIABLES
#----------------------------------------------#

variable "database_version" {
  description = "Database engine type and version."
  type        = string
  default     = "POSTGRES_15"
}

variable "maintenance_version" {
  description = "Specific maintenance version for the instance."
  type        = string
  default     = null
}

variable "encryption_key_name" {
  description = "KMS key name for disk encryption."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Prevents Terraform from destroying the instance."
  type        = bool
  default     = false
}

variable "replica_deletion_protection" {
  description = "Prevents Terraform from destroying the replica."
  type        = bool
  default     = false
}

variable "replica_deletion_protection_enabled" {
  description = "Prevents Terraform from destroying the replica."
  type        = bool
}

variable "root_password" {
  description = "Initial password for the root user."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "Type of instance: master or replica."
  type        = string
  default     = "CLOUD_SQL_INSTANCE"
}

#----------------------------------------------#
# SETTINGS VARIABLES
#----------------------------------------------#

variable "tier" {
  description = "Machine type determining CPU and RAM."
  type        = string
  default     = "db-f1-micro"
}

variable "edition" {
  description = "Cloud SQL edition: Enterprise or Plus."
  type        = string
  default     = "ENTERPRISE"
}

variable "activation_policy" {
  description = "Controls when the instance is active."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "Specifies HA (REGIONAL) or ZONAL availability."
  type        = string
  default     = "ZONAL"
}

variable "deletion_protection_enabled" {
  description = "GCP API flag preventing accidental deletion."
  type        = bool
  default     = false
}

variable "retain_backups_on_delete" {
  description = "Preserve backups when instance is deleted."
  type        = bool
  default     = false
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size."
  type        = bool
  default     = false
}

variable "disk_autoresize_limit" {
  description = "The maximum size to which storage can be auto increased."
  type        = number
  default     = 0
}

variable "disk_size" {
  description = "The disk size (in GB) for the Cloud SQL instance."
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the Cloud SQL instance."
  type        = string
  default     = "PD_HDD"
}

variable "pricing_plan" {
  description = "The pricing plan for the Cloud SQL instance."
  type        = string
  default     = "PER_USE"
}

#----------------------------------------------#
# BACKUP VARIABLES
#----------------------------------------------#

variable "backup_configuration" {
  description = "Settings for automated backups and retention."
  type = object({
    backups_enabled                = optional(bool)
    start_time                     = optional(string)
    location                       = optional(string)
    point_in_time_recovery_enabled = optional(bool)
    transaction_log_retention_days = optional(string)
    retained_backups               = optional(number)
    retention_unit                 = optional(string)
  })
  default = {}
}

#----------------------------------------------#
# IP CONFIGURATION VARIABLES
#----------------------------------------------#

variable "ip_configuration" {
  description = "Network access, private IP, and SSL."
  type = object({
    authorized_networks                           = optional(list(map(string)))
    ipv4_enabled                                  = optional(bool)
    private_network                               = optional(string)
    ssl_mode                                      = optional(string)
    allocated_ip_range                            = optional(string)
    enable_private_path_for_google_cloud_services = optional(bool)
    psc_enabled                                   = optional(bool)
    psc_allowed_consumer_projects                 = optional(list(string))
    server_ca_mode                                = optional(string)
    server_ca_pool                                = optional(string)
  })
  default = {}
}

#----------------------------------------------#
# DATABASE VARIABLES
#----------------------------------------------#

variable "database_flags" {
  description = "The database flags for the Cloud SQL instance."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "databases" {
  description = "Databases to create."
  type = map(object({
    charset         = optional(string)
    collation       = optional(string)
    deletion_policy = optional(string)
  }))
  default = {}
}

variable "users" {
  description = "Users to create (key = username)."
  type = map(object({
    type            = optional(string)
    deletion_policy = optional(string)
    password_policy = optional(object({
      allowed_failed_attempts      = optional(number)
      password_expiration_duration = optional(string)
      enable_failed_attempts_check = optional(bool)
      enable_password_verification = optional(bool)
    }))
  }))
  default = {}
}

variable "user_passwords" {
  description = "User passwords (key = username, value = password)."
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "user_types" {
  description = "User types (key = username, value = type)."
  type        = map(string)
  default     = {}
}

#----------------------------------------------#
# REPLICAS
#----------------------------------------------#

variable "replicas" {
  description = "Read replicas to create. To deploy and encrypt (CMEK) replica in different region is required to use key in the same region that replica will be deployed."
  type = map(object({
    region                = optional(string)
    name                  = optional(string)
    failover_target       = optional(bool)
    tier                  = optional(string)
    edition               = optional(string)
    encryption_key_name   = optional(string)
    availability_type     = optional(string)
    activation_policy     = optional(string)
    disk_type             = optional(string)
    disk_autoresize       = optional(bool)
    disk_autoresize_limit = optional(number)
    disk_size             = optional(string)
    user_labels           = map(string)
    ip_configuration = optional(object({
      ipv4_enabled                                  = optional(bool)
      private_network                               = optional(string)
      ssl_mode                                      = optional(string)
      enable_private_path_for_google_cloud_services = optional(bool)
    }))
    insights_cinfig = optional(object({
      query_insights_enabled  = optional(bool)
      query_plans_per_minute  = optional(number)
      query_string_length     = optional(number)
      record_application_tags = optional(bool)
      record_client_address   = optional(bool)
    }), null)
    database_flags = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default = null
}
