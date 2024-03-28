output "principal_id" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id
}

output "host" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].host
}
output "client_certificate" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].client_certificate
}
output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].cluster_ca_certificate
}
output "client_key" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].client_key
}