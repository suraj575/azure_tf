
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                    = var.kubernetes_cluster_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  dns_prefix              = var.kubernetes_cluster_name
  private_cluster_enabled = true

  #   kubernetes_version                = var.kubernetes_version
  #   node_resource_group               = var.node_resource_group
  #   azure_policy_enabled              = var.azure_policy_enabled
  #   node_os_channel_upgrade           = var.node_os_channel_upgrade
  role_based_access_control_enabled = true
  #   tags                              = var.tags
  # depends_on = [ azurerm_resource_group.resource_group, azurerm_virtual_network.vnet, azurerm_subnet.subnet]
  default_node_pool {
    name                = "system"
    node_count          = 1
    vm_size             = "Standard_DS2_v2"
    vnet_subnet_id      = var.subnet_id
    max_pods            = var.max_pods
    zones               = var.availability_zones
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.min_count
    max_count           = var.max_count

    #       os_disk_size_gb      = var.os_disk_size_gb
    #       type                 = var.type
    #       node_taints          = var.node_taints
    #       orchestrator_version = var.orchestrator_version
  }
  network_profile {
    network_plugin = "kubenet"
    dns_service_ip = "192.168.1.1"
    service_cidr   = "192.168.0.0/16"
    pod_cidr       = "172.16.0.0/22"
    load_balancer_sku = "standard"
  }
  identity {
    type = "SystemAssigned"
  }
}
