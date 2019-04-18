locals {
  healthcheck_location = "HTTP:${var.instance_port}/metrics"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.boundary_name}"
}
