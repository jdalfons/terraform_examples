provider "kubernetes" {
    config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Create a namespace argo
resource "kubernetes_namespace" "argo-namespace" {

 metadata {
   name = var.argo_namespace
 }
}


resource "helm_release" "argo_workflows" {
  depends_on = [kubernetes_namespace.argo-namespace]
  name = var.helm_release_name

  repository          = var.helm_repository
  repository_username = var.helm_repository_username
  repository_password = var.helm_repository_password

  chart     = var.helm_chart
  version   = var.chart_version
  namespace = var.argo_namespace
  timeout   = 1200

  values = [
    var.values,
  ]
}