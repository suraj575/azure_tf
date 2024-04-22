resource "azurerm_virtual_network" "quantvnet" {
  name                = "quant_adv_prod"
  location            = "East US "
  resource_group_name = "quant-rg-prod"
  address_space       = ["10.0.16.0/20"]
  tags = {
    env        = "${terraform.workspace}"
    cost_center = "quant"
  }
}
resource "azurerm_subnet" "app-subnet-01" {
  name                 = "app-subnet-01"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "quant-rg-prod"
  address_prefixes     = ["10.0.17.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}
resource "azurerm_subnet" "app-subnet-02" {
  name                 = "app-subnet-02"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "quant-rg-prod"
  address_prefixes     = ["10.0.18.0/24"]
}
resource "azurerm_subnet" "pe-subnet" {
  name                 = "pe-subnet"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "quant-rg-prod"
  address_prefixes     = ["10.0.20.0/24"]
}
resource "azurerm_subnet" "quant_vnet_prod" {
  name                 = "jumpserver"
  virtual_network_name = azurerm_virtual_network.quantvnet.name
  resource_group_name  = "quant-rg-prod"
  address_prefixes     = ["10.0.21.0/25"]
}
