resource "azurerm_container_registry" "main" {
  name = "acrmavencrest${var.environment}${random_string.suffix.result}"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false

  tags = local.tags
}
