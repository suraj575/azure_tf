

resource "azurerm_container_registry" "backend_acr" {
  name                          = var.backend_acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = false
  sku                           = "Premium"
  admin_enabled                 = true
}

resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_private_dns_zone_virtual_network_link" {
  name                  = "${var.backend_acr_name}-private-dns-zone-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns_zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "${var.backend_acr_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet

  private_service_connection {
    name                           = "${var.backend_acr_name}-service-connection"
    private_connection_resource_id = azurerm_container_registry.backend_acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = "${var.backend_acr_name}-private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_private_dns_zone.id]
  }
}


resource "azurerm_role_assignment" "acrpull" {
  principal_id                     = var.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.backend_acr.id
  skip_service_principal_aad_check = true
}



//frontend


resource "azurerm_container_registry" "frontend_acr" {
  name                          = var.frontend_acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = false
  sku                           = "Premium"
  admin_enabled                 = true
}

resource "azurerm_private_dns_zone" "frontend_acr_private_dns_zone" {
  name                = "frontend-privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "ffronend_acr_private_dns_zone_virtual_network_link" {
  name                  = "${var.frontend_acr_name}-private-dns-zone-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.frontend_acr_private_dns_zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet
}

resource "azurerm_private_endpoint" "frontend_acr_private_endpoint" {
  name                = "${var.frontend_acr_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet

  private_service_connection {
    name                           = "${var.frontend_acr_name}-service-connection"
    private_connection_resource_id = azurerm_container_registry.frontend_acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = "${var.frontend_acr_name}-private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.frontend_acr_private_dns_zone.id]
  }
}


resource "azurerm_role_assignment" "frontend_acrpull" {
  principal_id                     = var.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.frontend_acr.id
  skip_service_principal_aad_check = true
}
