# data "terraform_remote_state" "acm" {
#   backend = "s3"
#   config = {
#     # Replace this with your bucket name!
#     bucket = "mt-tooling-tfstate-${var.env_name}-${var.aws_account_short_id}"
#     key    = "${var.env_name}/${var.local_dir}/${var.aws_region}/${var.project_name}/acm/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

terraform {
  backend "gcs" {}
}

resource "helm_release" "geotrade-ingress-nginx-ui" {
    name = "geotrade-ingress-nginx-ui"
    chart = "ingress-nginx"
    namespace = "ingress-nginx-ui"
    version = "3.34.0"
    repository = "https://kubernetes.github.io/ingress-nginx"

    values = [
    "${file("values.yaml")}"
    ]
    
    set {
        name  = "controller.metrics.enabled"
        value = "true" 
    }
}