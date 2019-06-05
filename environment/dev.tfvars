environment = "dev"
instance_type = "t3.small"
image_tag = "latest"
application_name = "elasticbeanstalk-exporter"
stack_name_regex = "^64bit Amazon Linux (.*) Multi-container Docker (.*)$"
instance_port = "9552"
health_reporting_system = "enhanced"
enable_cloudwatch_logs = "true"
delete_logs_on_termination = "true"
tags = {
    "Environment" = "Development"
    "Application" =  "elasticbeanstalk-exporter"
    "Stack"  = "https://github.com/jeremietharaud/elasticbeanstalk-stack"
}
