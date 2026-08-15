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

variable "container_image" {
  description = "Container image initially deployed to Container Apps."
  type        = string
  default     = "mcr.microsoft.com/k8se/quickstart:latest"
}

variable "database_url" {
  description = "PostgreSQL connection string."
  type        = string
  sensitive   = true
  default     = ""
}

variable "auth_secret" {
  description = "Authentication secret."
  type        = string
  sensitive   = true
  default     = ""
}

variable "frontdoor" {
  description = "Azure frontdoor name."
  type        = string
  default     = "container"
}