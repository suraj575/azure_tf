
resource "random_password" "cosmosdb_postgresql_passwords" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_cosmosdb_postgresql_cluster" "cosmos" {
  name                            = var.cosmos_db_cluster_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  administrator_login_password    = random_password.cosmosdb_postgresql_passwords.result
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 0
  node_public_ip_access_enabled   = false
  coordinator_public_ip_access_enabled = false
  citus_version                        = "12.1"
  sql_version                          = "16"
   depends_on = [
    random_password.cosmosdb_postgresql_passwords
  ]

}

resource "azurerm_private_dns_zone" "cosmos" {
  name                = "privatelink.postgreshsc.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "cosmos-pe" {
  name                = "cosmos-db-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet

  private_dns_zone_group {
    name                 = "cosmos-private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.cosmos.id]
  }

  private_service_connection {
    name                           = "cosmos-db-service-connection"
    private_connection_resource_id = azurerm_cosmosdb_postgresql_cluster.cosmos.id
    subresource_names              = ["coordinator"]
    is_manual_connection           = false
  }
}