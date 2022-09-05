terraform {
  backend "gcs" {}
}

resource "helm_release" "geotrade-loki" {
  name  = "geotrade-loki"
  chart = "loki-stack"
  version    = "2.5.0"
  repository = "https://grafana.github.io/helm-charts"
  namespace = "loki"
  values = [
    "${file("values.yaml")}"
  ]
  set {
    name  = "loki.persistence.enabled"
    value = "true"
  }

  set {
    name  = "loki.persistence.size"
    value = "10Gi"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.type"
    value = "pvc"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set {
    name = "config.table_manager.retention_deletes_enabled"
    value = "true"
  }

  set {
    name = "config.table_manager.retention_period"
    value = "720h"
  }

  set {
    name  = "persistence.existingClaim"
    value = "pvc-loki"
  }

  set {
    name  = "persistence.subPath"
    value = "loki"
  }


}