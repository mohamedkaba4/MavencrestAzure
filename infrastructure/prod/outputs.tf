output "resource_group_name" {
  description = "Name of the Mavencrest resource group."
  value       = azurerm_resource_group.main.name
}

output "container_registry_name" {
  description = "Name of the Azure Container Registry."
  value       = azurerm_container_registry.main.name
}

output "container_registry_login_server" {
  description = "Address used to push and pull container images."
  value       = azurerm_container_registry.main.login_server
}

output "container_app_name" {
  description = "Name of the Mavencrest storefront Container App."
  value       = azurerm_container_app.storefront.name
}

output "container_app_url" {
  description = "Public HTTPS URL of the storefront."
  value       = "https://${azurerm_container_app.storefront.latest_revision_fqdn}"
}
