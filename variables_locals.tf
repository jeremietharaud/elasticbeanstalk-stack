locals {
  healthcheck_location = "HTTP:${var.instance_port}/metrics"
}
