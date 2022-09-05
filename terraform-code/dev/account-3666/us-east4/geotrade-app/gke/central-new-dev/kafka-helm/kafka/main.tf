terraform {
  backend "gcs" {}
}

resource "helm_release" "geotrade-kafka" {
  name  = "geotrade-kafka"
  chart = "kafka"
  namespace = "kafka"
  version    = "14.0.1"
  repository = "https://charts.bitnami.com/bitnami"

  values = [
    "${file("values.yaml")}"
  ]
  
  set {
      name  = "externalAccess.enabled"
      value = "true"
    }
  
  set {
      name  = "externalAccess.service.type"
      value = "LoadBalancer"
    }
  
  set {
      name  = "externalAccess.service.port"
      value = "9094"
    }

  set {
      name  = "externalAccess.service.loadBalancerIPs[0]"
      value = "34.145.189.37"
    }

  set {
      name  = "master.persistence.existingClaim"
      value = "pvc-kafka-dev"
    }
  
}
