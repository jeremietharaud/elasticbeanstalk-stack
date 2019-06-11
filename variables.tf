variable "region" {
  description = "Region to deploy the stack"
  default     = "do-not-use"
}

variable "environment" {
  description = "Name of the environment to retrieve parameters in Parameter Store"
  default     = "do-not-use"
}

variable "application_name" {
  description = "Name of the EB application"
  default     = "do-not-use"
}

variable "stack_name_regex" {
  description = "Regex of the stack name to retrieve"
  default     = "do-not-use"
}

variable "instance_type" {
  description = "The instance type used to run the application in an Elastic Beanstalk environment."
  default     = "do-not-use"
}

variable "instance_port" {
  description = "Port used by the container"
  default     = "do-not-use"
}

variable "image_tag" {
  description = "Version of the application to deploy on Elastic Beanstalk Environment"
  default     = "do-not-use"
}

variable "health_reporting_system" {
  description = "Type of health reporting system: basic or enhanced"
  default     = "do-not-use"
}

variable "enable_cloudwatch_logs" {
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in the environment."
  default     = "do-not-use"
}

variable "delete_logs_on_termination" {
  description = "Whether to delete the log groups when the environment is terminated. If false, the logs are kept 7 days."
  default     = "do-not-use"
}

variable "alb_health_check_location" {
  description = "URL for the ALB health check"
  default     = "do-not-use"
}
