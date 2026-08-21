output "storefront_container_app_name" {
  description = "Name of the Mavencrest storefront Container App."
  value       = azurerm_container_app.storefront.name
}

output "storefront_container_app_url" {
  description = "Public HTTPS URL of the storefront Container App."
  value       = "https://${azurerm_container_app.storefront.latest_revision_fqdn}"
}

output "admin_container_app_name" {
  description = "Name of the Mavencrest admin Container App."
  value       = azurerm_container_app.admin.name
}

output "admin_container_app_url" {
  description = "Public HTTPS URL of the admin Container App."
  value       = "https://${azurerm_container_app.admin.latest_revision_fqdn}"
}
