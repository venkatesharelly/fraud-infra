resource "kubernetes_namespace_v1" "fraud" {
  metadata {
    name = "fraud"
  }
}

resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "kubernetes_namespace_v1" "sonarqube" {
  metadata {
    name = "sonarqube"
  }
}

resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  namespace  = kubernetes_namespace_v1.sonarqube.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "sonarqube"

  values = [yamlencode({
    postgresql = {
      enabled = false
    }
    service = {
      type = "LoadBalancer"
      port = 9000
    }
    persistence = {
      enabled = true
      size    = "20Gi"
    }
  })]

  depends_on = [kubernetes_namespace_v1.sonarqube]
}