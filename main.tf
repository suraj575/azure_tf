resource "azurerm_resource_group" "this" {
  location = var.location
  name     = "${var.name}-Group"
}


module "vnetwork" {
  source = "./modules/vnet"

  vnet_name =  var.vnet_name
  address_space = var.address_space
  resource_group_name = azurerm_resource_group.this.name
}