resource "azurerm_public_ip" "this" {
  name                = "${var.name}-Public-IP"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [1]
}

#Nat Gateway
resource "azurerm_nat_gateway" "this" {
  name                    = "${var.name}-NAT"
  location                = azurerm_resource_group.this.location
  resource_group_name     = azurerm_resource_group.this.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = [1]
}

# Nat - Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "this" {
 nat_gateway_id       = azurerm_nat_gateway.this.id
 public_ip_address_id = azurerm_public_ip.this.id
}

# NAT - Subnets association
resource "azurerm_subnet_nat_gateway_association" "this" {
 subnet_id      = azurerm_subnet.private.id
 nat_gateway_id = azurerm_nat_gateway.this.id
}