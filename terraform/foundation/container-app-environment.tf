resource "azurerm_container_app_environment" "main" {
  count = var.create_shared_platform ? 1 : 0
  
  name                       = "cae-${local.prefix}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  tags = local.tags
}
