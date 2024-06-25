variable "general" {
  type        = map
  description = "General information about the instance"
  default     = {}
}

variable "snapshot_schedule" {
  type        = map
  description = "General information about the instance"
  default     = {}
}

variable "disable_spot" {
  type    = string
  default = "STANDARD"
}

variable "project" {
  type    = string
  default = ""
}

variable "enable_automatic_restart" {
  type    = string
  default = "true"
}

variable "enable_boot_disk_sources" {
  type        = string
  default     = "false"
  description = "Variable for enabling boot_disk from source support"
}

variable "boot_disk_sources" {
  type        = list
  default     = []
  description = "List of boot disk source for created instances"
}

variable "metadata" {
  type        = map
  default     = {}
  description = "Accessable metadata for the instance"
}

variable "labels" {
  type        = map
  default     = {}
  description = "Labels to be assigned to the instance"
}

variable "data_disk" {
  description = "Configuration for Google Compute Engine disks"
  type        = map(object({
    size        = string
    type        = string
  }))
  default = {}
}

variable "network_interface" {
  type        = map
  default     = {}
  description = "Network configuration for the instance"
}

variable "miscellaneous" {
  type        = map
  default     = {}
  description = "Other configurations for the instance"
}

variable "guest_accelerator" {
  type        = list
  default     = []
  description = " List of the type and count of accelerator cards attached to the instance, outside the GPU originated from instance type"
}

variable "service_account" {
  type = map

  default = {
    # Please check this scopes, make sure the scopes only expose requried one
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }

  description = "Service account to be attached into the instance"
}

variable "scheduling" {
  type        = map
  default     = {}
  description = "Scheduling configuration for the instance"
}

variable "tags" {
  type        = list
  default     = []
  description = "Tags to be assigned to the instance"
}

variable "region" {
  description = "region for the resource"

  type    = string
  default = "asia-southeast1"
}

variable "zones" {
  description = "list of zones"

  type    = list
  default = ["asia-southeast1-a", "asia-southeast1-b", "asia-southeast1-c"]
}

variable "zone" {
  description = "zone"
  type        = string
  default     = "asia-southeast1-b"
}

variable "deletion_protection" {
  description   = "deletion_protection"
  type          = bool
  default       = false
}

variable "boot_disk" {
  description = "Main disk for the instance (Os installation)"
  type        = map
  default     = {}
}

variable "ip_public" {
  description = "Enable or disable public IP"
  type        = bool
  default     = false
}
