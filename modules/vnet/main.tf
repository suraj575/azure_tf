resource "azurerm_virtual_network" "quantvnet" {
  name                = "quant_adv_dev"
  location            = "East US "
  resource_group_name = "inizio_adv_dev"
  address_space       = ["10.200.0.0/20"]
  tags = {
    env        = "${terraform.workspace}"
    cost_center = "quant"
  }
}
resource "azurerm_subnet" "app-subnet-01" {
  name                 = "app-subnet-01"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "inizio_adv_dev"
  address_prefixes     = ["10.200.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}
resource "azurerm_subnet" "app-subnet-02" {
  name                 = "app-subnet-02"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "inizio_adv_dev"
  address_prefixes     = ["10.200.3.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}
resource "azurerm_subnet" "pe-subnet" {
  name                 = "pe-subnet"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "inizio_adv_dev"
  address_prefixes     = ["10.200.4.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}
resource "azurerm_subnet" "quant_vnet_dev" {
  name                 = "quant_vnet_dev"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "inizio_adv_dev"
  address_prefixes     = ["10.200.0.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}
