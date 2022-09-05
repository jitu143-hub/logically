terraform {
  backend "gcs" {}
}

resource "kubernetes_namespace" "geotrade-namespace" {
  metadata {
    annotations = {
      name = "geotrade-namespace-annotation"
    }

    labels = {
      mylabel = "geotrade-namespace"
    }

    name = var.kubernetes_namespace
  }
}