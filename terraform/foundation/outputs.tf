output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "container_app_environment_id" {
  value = try(azurerm_container_app_environment.main[0].id, null)
}

output "container_registry_id" {
  value = try(azurerm_container_registry.main[0].id, null)
}

output "container_registry_name" {
  value = try(azurerm_container_registry.main[0].name, null)
}

output "container_registry_login_server" {
  value = try(azurerm_container_registry.main[0].login_server, null)
}

output "key_vault_id" {
  value = azurerm_key_vault.main.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.main.vault_uri
}

output "app_identity_id" {
  value       = azurerm_user_assigned_identity.app.id
  description = "Resource ID of the User-Assigned Managed Identity."
}

output "app_identity_client_id" {
  value       = azurerm_user_assigned_identity.app.client_id
  description = "Client ID of the User-Assigned Managed Identity."
}
