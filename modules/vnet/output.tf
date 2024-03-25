output "aks_nonprod_subnet" {
  value = azurerm_subnet.adv_quant_nonprod_subnet.id
}

output "pe_subnet" {
  value = azurerm_subnet.default.id
}
output "vnet" {
  value = azurerm_virtual_network.aksvnet.id
}
