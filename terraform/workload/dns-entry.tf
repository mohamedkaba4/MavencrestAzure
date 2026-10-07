resource "azurerm_dns_cname_record" "storefront" {
  name                = "store"
  zone_name           = "az.mavencrest.site"
  resource_group_name = "rg-hub-dns-eastus"
  ttl                 = 300
  provider            = azurerm.connectivity
  record              = azurerm_container_app.storefront.ingress[0].fqdn
}

resource "azurerm_dns_txt_record" "storefront_validation" {
  provider = azurerm.connectivity
  name                = "asuid.store"
  zone_name           = "az.mavencrest.site"
  resource_group_name = "rg-hub-dns-eastus"
  ttl                 = 300

  record {
    value = azurerm_container_app.storefront.custom_domain_verification_id
  }
}

resource "azurerm_dns_cname_record" "admin" {
  name                = "admin"
  zone_name           = "az.mavencrest.site"
  resource_group_name = "rg-hub-dns-eastus"
  ttl                 = 300
  provider            = azurerm.connectivity
  record              = azurerm_container_app.admin.ingress[0].fqdn
}

resource "azurerm_dns_txt_record" "admin_validation" {
  provider = azurerm.connectivity
  name                = "asuid.admin"
  zone_name           = "az.mavencrest.site"
  resource_group_name = "rg-hub-dns-eastus"
  ttl                 = 300

  record {
    value = azurerm_container_app.admin.custom_domain_verification_id
  }
}