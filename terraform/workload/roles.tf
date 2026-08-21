resource "azurerm_role_assignment" "store_acr_pull" {
  scope                = data.terraform_remote_state.shared.outputs.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_container_app.storefront.identity[0].principal_id
}

resource "azurerm_role_assignment" "admin_acr_pull" {
  scope                = data.terraform_remote_state.shared.outputs.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_container_app.admin.identity[0].principal_id
}
