terraform {
  backend "gcs" {}
}

resource "helm_release" "geotrade-redis" {
    name = "geotrade-redis"
    chart = "redis"
    namespace = "redis"
    version = "14.8.6"
    repository = "https://charts.bitnami.com/bitnami"

    values = [
    "${file("values.yaml")}"
    ]

    set {
      name  = "master.persistence.existingClaim"
      value = "pvc-redis"
    }

    set {
      name  = "global.redis.password"
      value = "welcome@123"
    }

    
    
}