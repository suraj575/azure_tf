# resource "azurerm_resource_group" "this" {
#   location = var.location
#   name     = var.resource_group_name
# }

# module "cosmos" 
#   source = "./modules/cosmosDB"

#   cosmos_db_cluster_name = var.cosmos_db_cluster_name
#   resource_group_name = azurerm_resource_group.this.name
#   location = azurerm_resource_group.this.location

# }

module "aks" {
  source = "./modules/aks"

  kubernetes_cluster_name = var.kubernetes_cluster_name
  resource_group_name     = "quant-rg-nonprod" //azurerm_resource_group.this.name
  location                = "East US"          //azurerm_resource_group.this.location
  subnet_id               = module.vnet.aks_nonprod_subnet
  availability_zones      = var.availability_zones
  enable_auto_scaling     = var.enable_auto_scaling
  min_count               = var.min_count
  max_count               = var.max_count
  max_pods                = var.max_pods

}
module "vnet" {

  source = "./modules/vnet"
}

module "acr" {
  source = "./modules/acr"

  pe_subnet           = module.vnet.pe_subnet
  resource_group_name = "quant-rg-nonprod" //azurerm_resource_group.this.name
  location            = "East US"          //azurerm_resource_group.this.location
  backend_acr_name    = var.backend_acr_name
  principal_id        = module.aks.principal_id
  frontend_acr_name   = var.frontend_acr_name
  vnet                = module.vnet.vnet
}

module "nginx" {
  source = "./modules/nginx-ingress"
}

module "cert-manager" {
  source = "./modules/cert-manager"
}