# Fetch the resource group details dynamically from foundation output
data "azurerm_resource_group" "rg" {
  name = data.terraform_remote_state.foundation.outputs.resource_group_name
}

# User-Assigned Managed Identities
resource "azurerm_user_assigned_identity" "storefront" {
  name                = "id-${local.prefix}-storefront"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "admin" {
  name                = "id-${local.prefix}-admin"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Role Assignments
resource "azurerm_role_assignment" "store_acr_pull" {
  scope                = data.terraform_remote_state.shared.outputs.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.storefront.principal_id
}

resource "azurerm_role_assignment" "admin_acr_pull" {
  scope                = data.terraform_remote_state.shared.outputs.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.admin.principal_id
}

resource "azurerm_role_assignment" "store_kv_read" {
  scope                = data.terraform_remote_state.foundation.outputs.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.storefront.principal_id
}

resource "azurerm_role_assignment" "admin_kv_read" {
  scope                = data.terraform_remote_state.foundation.outputs.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.admin.principal_id
}