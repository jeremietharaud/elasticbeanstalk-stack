variable "region" {
  description = "Region to deploy the stack"
  default     = "eu-west-3"
}

variable "boundary_name" {
  description = "Name of the permissions boundary for creating roles (optional)"
  default     = ""
}

variable "application_name" {
  description = "Name of the application"
  default     = "elasticbeanstalk-exporter"
}

variable "stack_name_regex" {
  description = "Regex of the stack name to retrieve"
  default     = "^64bit Amazon Linux (.*) Multi-container Docker (.*)$"
}

variable "instance_port" {
  description = "Port used by the container"
  default     = "9552"
}

variable "health_reporting_system" {
  description = "Type of health reporting system: basic or enhanced"
  default     = "enhanced"
}

variable "enable_cloudwatch_logs" {
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in the environment."
  default     = "true"
}

variable "delete_logs_on_termination" {
  description = "Whether to delete the log groups when the environment is terminated. If false, the logs are kept 7 days."
  default     = "true"
}

variable "tags" {
  description = "Map of tags"
  type        = "map"

  default = {
    "Application" = "elasticbeanstalk-exporter"
  }
}
