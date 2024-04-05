output "aks_nonprod_subnet" {
  value = azurerm_subnet.app-subnet-01.id
}
output "aks_nonprod_subnet-2" {
  value = azurerm_subnet.app-subnet-02.id
}


output "pe_subnet" {
  value = azurerm_subnet.pe-subnet.id
}
output "vnet" {
  value = azurerm_virtual_network.quantvnet.id
}
