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