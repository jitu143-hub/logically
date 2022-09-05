provider "grafana" {
  url  = "http://grafana.35.199.37.53.nip.io/"
  auth = "admin:WS9UgAKsWJIUiRpGyi9SWLyMpJ7xIZ57stfU5SuT"
}

variable "datasource_name" {
  default = "geotrade-apps-logs"
}

resource "grafana_data_source" "Loki" {
  type       = "Loki"
  name       = "${var.datasource_name}"
  url        = "http://geotrade-loki:3100"
  is_default = true
}

resource "grafana_folder" "collection" {
  title = "geotrade-apps-logs"
}

data "template_file" "connectors-elements" {
  template = "${file("dashboards/connectors-elements-dashboard.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "connectors-elements" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.connectors-elements.rendered}"

  # depends_on = [
  #   "grafana_data_source.Loki",
  # ]
}

data "template_file" "alarm-management-api" {
  template = "${file("dashboards/alarm-management-api-dashboard.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "alarm-management-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.alarm-management-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.connectors-elements",
  # ]
}

data "template_file" "data-flow-jobs" {
  template = "${file("dashboards/data-flow-jobs.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "data-flow-jobs" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.data-flow-jobs.rendered}"

#   # depends_on = [
#   #   "grafana_dashboard.Loki-Statistics-k8s",
#   # ]
}

data "template_file" "data-migration-job" {
  template = "${file("dashboards/data-migration-job.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "data-migration-job" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.data-migration-job.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-flow-jobs.json",
  # ]
}

data "template_file" "express-api" {
  template = "${file("dashboards/express-api.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "express-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.express-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-flow-jobs",
  # ]
}

data "template_file" "gql-gateway" {
  template = "${file("dashboards/gql-gateway.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "gql-gateway" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.gql-gateway.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}

data "template_file" "gql-service" {
  template = "${file("dashboards/gql-service.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "gql-service" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.gql-service.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}

data "template_file" "imsi-subscription-api" {
  template = "${file("dashboards/imsi-subscription-api.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "imsi-subscription-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.imsi-subscription-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}

data "template_file" "network-elements-management-api" {
  template = "${file("dashboards/network-elements-management-api.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "network-elements-management-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.network-elements-management-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}

data "template_file" "notification-api" {
  template = "${file("dashboards/notification-api.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "notification-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.notification-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}


data "template_file" "orgnization-onboarding-api" {
  template = "${file("dashboards/orgnization-onboarding-api.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "orgnization-onboarding-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.orgnization-onboarding-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}

data "template_file" "user-management-api" {
  template = "${file("dashboards/user-management-api.json")}"

  vars = {
    Loki = "${var.datasource_name}"
  }
}

resource "grafana_dashboard" "user-management-api" {
  folder      = grafana_folder.collection.id
  config_json = "${data.template_file.user-management-api.rendered}"

  # depends_on = [
  #   "grafana_dashboard.data-migration-job",
  # ]
}