terraform {
  backend "gcs" {}
}

resource "helm_release" "geotrade-dashboard" {
  name  = "geotrade-dashboard"
  chart = "kubernetes-dashboard"
  namespace = "dashboard"
  version    = "4.2.0"
  repository = "https://kubernetes.github.io/dashboard/"

  values = [
    "${file("values.yaml")}"
  ]
}