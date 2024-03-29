resource "helm_release" "cert-manager" {
  name             = "cm"
  namespace        = "cert-manager"
  create_namespace = false
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v1.5.3"
  values = [
     file("${path.module}/values.yaml")
  ]
}