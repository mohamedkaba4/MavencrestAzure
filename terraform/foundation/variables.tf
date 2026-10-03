variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "create_shared_platform" {
  type    = bool
  default = true
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription where the Mavencrest foundation resources are deployed."
}

variable "infrastructure_subnet_id" {
  type        = string
  description = "Subnet resource ID used by the Azure Container Apps environment."
}
