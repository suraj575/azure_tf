
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                              = var.kubernetes_cluster_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  dns_prefix                        = var.kubernetes_cluster_name
  private_cluster_enabled           = true
  role_based_access_control_enabled = true
  tags = {
    env        = "${terraform.workspace}"
    cost_center = "quant"
  }
  default_node_pool {
    name                = var.node_pool_name
    node_count          = 3
    vm_size             = "Standard_D2s_v3"
    vnet_subnet_id      = var.subnet_id
    max_pods            = var.max_pods
    zones               = var.availability_zones
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.min_count
    max_count           = var.max_count
    tags = {
      env        = "${terraform.workspace}"
      cost_center = "quant"
  }

  }
  network_profile {
    network_plugin    = "kubenet"
    dns_service_ip    = "192.168.1.1"
    service_cidr      = "192.168.0.0/16"
    pod_cidr          = "172.16.0.0/22"
    load_balancer_sku = "standard"
  }
  identity {
    type = "SystemAssigned"
  }
}
