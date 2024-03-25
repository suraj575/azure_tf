
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_cosmosdb_postgresql_cluster" "example" {
  name                            = var.cosmos_db_cluster_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  administrator_login_password    = random_password.password.result
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 0
  node_public_ip_access_enabled   = false
}
