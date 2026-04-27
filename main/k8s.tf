resource "kubernetes_namespace" "sonarqube" {
  metadata { name = "sonarqube" }
}

resource "kubernetes_namespace" "argocd" {
  metadata { name = "argocd" }
}

resource "kubernetes_namespace" "fraud" {
  metadata { name = "fraud" }
}