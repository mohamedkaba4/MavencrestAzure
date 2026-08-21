variable "storefront_container_image" {
  description = "Bootstrap image initially deployed to the storefront Container App."
  type        = string
  default     = "mcr.microsoft.com/k8se/quickstart:latest"
}

variable "admin_container_image" {
  description = "Bootstrap image initially deployed to the admin Container App."
  type        = string
  default     = "mcr.microsoft.com/k8se/quickstart:latest"
}

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

variable "frontdoor" {
  description = "Azure Front Door name."
  type        = string
  default     = "container"
}