resource "azurerm_virtual_network" "aksvnet" {
  name                = "adv_quant_nonprod_network"
  location            = "East US "
  resource_group_name = "quant-rg-nonprod"
  address_space       = ["10.2.0.0/16"]
   tags                    = {
           env       = "nonprod" 
           Name       = "adv_quant_nonprod_network" 
           costcenter = "quant"
        }
}
resource "azurerm_subnet" "default" {
  name                 = "default"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = "quant-rg-nonprod"
  address_prefixes     = ["10.2.0.0/24"]
}
resource "azurerm_subnet" "azure-firewall-subnet" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = "quant-rg-nonprod"
  address_prefixes     = ["10.2.1.64/26"]
}
resource "azurerm_subnet" "adv_quant_nonprod_subnet" {
  name                 = "adv_quant_nonprod_subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = "quant-rg-nonprod"
  address_prefixes     = ["10.2.2.0/24"]
}
resource "azurerm_subnet" "azure-bastion-subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = "quant-rg-nonprod"
  address_prefixes     = ["10.2.1.0/26"]
}