resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version = "TLS1_2"
  tags = {
    env        = "${terraform.workspace}"
    cost_center = "quant"
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}


resource "azurerm_private_dns_zone_virtual_network_link" "acr_private_dns_zone_virtual_network_link" {
  name                  = "${var.storage_account_name}-private-dns-zone-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${var.storage_account_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet

  private_service_connection {
    name                           = "${var.storage_account_name}-service-connection"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "${var.storage_account_name}-private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone.id]
  }

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}

resource "azurerm_private_dns_a_record" "storage_account" {
  name                = "storageaccount"
  zone_name           = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.private_endpoint.private_service_connection.0.private_ip_address]
}
