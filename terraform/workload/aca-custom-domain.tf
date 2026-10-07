resource "azurerm_container_app_custom_domain" "storefront" {
  name             = "store.az.mavencrest.site"
  container_app_id = azurerm_container_app.storefront.id

  depends_on = [
    azurerm_dns_cname_record.storefront,
    azurerm_dns_txt_record.storefront_validation
  ]

  lifecycle {
    ignore_changes = [
      certificate_binding_type,
      container_app_environment_certificate_id
    ]
  }
}

resource "azurerm_container_app_custom_domain" "admin" {
  name             = "admin.az.mavencrest.site"
  container_app_id = azurerm_container_app.admin.id

  depends_on = [
    azurerm_dns_cname_record.admin,
    azurerm_dns_txt_record.admin_validation
  ]

  lifecycle {
    ignore_changes = [
      certificate_binding_type,
      container_app_environment_certificate_id
    ]
  }
}
