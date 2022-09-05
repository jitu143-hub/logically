provider "grafana" {
  url  = "http://grafana.35.199.37.53.nip.io/"
  auth = "admin:WS9UgAKsWJIUiRpGyi9SWLyMpJ7xIZ57stfU5SuT"
}

variable "datasource_name" {
  default = "prometheus-k8s"
}

resource "grafana_data_source" "prometheus" {
  type       = "prometheus"
  name       = "${var.datasource_name}"
  url        = "http://geotrade-loki-prometheus-server:80"
  is_default = true
}

resource "grafana_folder" "collection" {
  title = "geotrade-k8s-monitoring"
}

data "template_file" "Kubernetes-Cluster-Monitoring" {
  template = "${file("dashboards/k8-cluster-dashboard.json")}"

  vars = {
    DS_PROMETHEUS-K8S = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "Kubernetes-Cluster-Monitoring" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.Kubernetes-Cluster-Monitoring.rendered}"

  depends_on = [
    "grafana_data_source.prometheus",
  ]
}

# data "template_file" "Prometheus-Statistics-k8s" {
#   template = "${file("dashboards/Prometheus-Statistics.json")}"

#   vars = {
#     DS_PROMETHEUS-K8S = "${var.datasource_name}"
#   }
# }

# resource "grafana_dashboard" "Prometheus-Statistics-k8s" {
#   folder      = grafana_folder.collection.id
#   config_json = "${data.template_file.Prometheus-Statistics-k8s.rendered}"

#   depends_on = [
#     "grafana_dashboard.Kubernetes-Cluster-Monitoring",
#   ]
# }

data "template_file" "All-Nodes-Dashboard" {
  template = "${file("dashboards/node-exporter.json")}"

  vars = {
    DS_PROMETHEUS-K8S = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "All-Nodes-Dashboard" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.All-Nodes-Dashboard.rendered}"

  # depends_on = [
  #   "grafana_dashboard.Prometheus-Statistics-k8s",
  # ]
}

# data "template_file" "Kubernetes-Pods" {
#   template = "${file("dashboards/kubernetes-pods.json")}"

#   vars = {
#     DS_PROMETHEUS-K8S = "${var.datasource_name}"
#   }
# }

# resource "grafana_dashboard" "Kubernetes-Pods" {
#   folder      = grafana_folder.collection.id
#   config_json = "${data.template_file.Kubernetes-Pods.rendered}"

#   depends_on = [
#     "grafana_dashboard.All-Nodes-Dashboard",
#   ]
# }

# data "template_file" "Node-Dashboard" {
#   template = "${file("dashboards/node-dashboard.json")}"

#   vars = {
#     DS_PROMETHEUS-K8S = "${var.datasource_name}"
#   }
# }

# resource "grafana_dashboard" "Node-Dashboard" {
#   folder      = grafana_folder.collection.id
#   config_json = "${data.template_file.Node-Dashboard.rendered}"

#   depends_on = [
#     "grafana_dashboard.Kubernetes-Pods",
#   ]
# }

data "template_file" "Requests" {
  template = "${file("dashboards/requests.json")}"

  vars = {
    DS_PROMETHEUS-K8S = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "Requests" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.Requests.rendered}"

  # depends_on = [
  #   "grafana_dashboard.Node-Dashboard",
  # ]
}
