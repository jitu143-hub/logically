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

resource "helm_release" "geotrade-ingress-nginx" {
    name = "geotrade-ingress-nginx"
    chart = "ingress-nginx"
    namespace = "ingress-nginx"
    version = "3.23.0"
    repository = "https://kubernetes.github.io/ingress-nginx"

    values = [
    "${file("values.yaml")}"
    ]

    # set {
    #     name  = "service.annotations.service.beta.kubernetes.io/aws-load-balancer-backend-protocol"
    #     value = "http" 
    # }

    # set {
    #     name = "service.annotations.service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout"
    #     value = "60"
    # }

    # set {
    #     name = "service.annotations.service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    #     value = "true"
    # }

    # set {
    #     name = "controller.service.annotations.service.beta.kubernetes.io/aws-load-balancer-ssl-cert"
    #     value = data.terraform_remote_state.acm.outputs.acm_arn
    # }
    # set {
    #     name = "controller.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-ssl-cert"
    #     value = data.terraform_remote_state.acm.outputs.acm_arn
    # }

    # set {
    #     name = "service.annotations.service.beta.kubernetes.io/aws-load-balancer-ssl-ports"
    #     value = "https"
    # }

    # set {
    #     name = "service.annotations.service.beta.kubernetes.io/aws-load-balancer-type"
    #     value = "nlb"
    # }

    # # set {
    # #     name = "service.internal.enabled"
    # #     value = "true"
    # # }

    # set {
    #     name  = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-internal"
    #     value = "true" 
    # }

    # set {
    #     name  = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-backend-protocol"
    #     value = "http" 
    # }

    # set {
    #     name = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout"
    #     value = "60"
    # }

    # set {
    #     name = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    #     value = "true"
    # }

    # set {
    #     name = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-ssl-cert"
    #     value = data.terraform_remote_state.acm.outputs.acm_arn
    # }

    # set {
    #     name = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-ssl-ports"
    #     value = "https"
    # }

    # set {
    #     name = "service.internal.annotations.service.beta.kubernetes.io/aws-load-balancer-type"
    #     value = "nlb"
    # }

}