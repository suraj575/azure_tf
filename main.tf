resource "azurerm_resource_group" "this" {
  location = "East US"
  name     = "inizio_adv_dev"
  tags = {
    env        = "${terraform.workspace}"
    cost_center = "quant"
  }
}

module "cosmos" {
  source = "./modules/cosmosDB"

  cosmos_db_cluster_name = var.cosmos_db_cluster_name
  resource_group_name    = azurerm_resource_group.this.name
  location               = azurerm_resource_group.this.location
  pe_subnet              = module.vnet.pe_subnet

}

module "aks" {
  source = "./modules/aks"

  kubernetes_cluster_name = var.kubernetes_cluster_name
  resource_group_name     = azurerm_resource_group.this.name
  location                = azurerm_resource_group.this.location
  subnet_id               = module.vnet.aks_nonprod_subnet
  availability_zones      = var.availability_zones
  enable_auto_scaling     = var.enable_auto_scaling
  min_count               = var.min_count
  max_count               = var.max_count
  max_pods                = var.max_pods
  node_pool_name          = var.node_pool_name

}
module "vnet" {

  source = "./modules/vnet"
}

module "acr" {
  source = "./modules/acr"

  pe_subnet           = module.vnet.pe_subnet
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  acr_name            = var.acr_name
  principal_id        = module.aks.principal_id
  vnet                = module.vnet.vnet
}

module "nginx" {
  source = "./modules/nginx-ingress"
}

module "cert-manager" {
  source = "./modules/cert-manager"
}
