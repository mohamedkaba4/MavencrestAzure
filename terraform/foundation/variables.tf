variable "location" {
  description = "Azure region used for Mavencrest resources."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "prod"
}

variable "create_shared_platform" {
  type    = bool
  default = false
}
