# Retrieves environment full name from SSM Parameter Store
data "aws_ssm_parameter" "environment" {
  name = "/elasticbeanstalk-stack/${var.environment}/environment"
}

# Retrieves the instance type from SSM Parameter Store
data "aws_ssm_parameter" "instance_type" {
  name = "/elasticbeanstalk-stack/${var.environment}/instance_type"
}

# Retrieves the image tag name from SSM Parameter Store
data "aws_ssm_parameter" "image_tag" {
  name = "/elasticbeanstalk-stack/${var.environment}/image_tag"
}

# Retrieves the application name from SSM Parameter Store
data "aws_ssm_parameter" "application_name" {
  name = "/elasticbeanstalk-stack/${var.environment}/application_name"
}

# Retrieves the stack name regex from SSM Parameter Store
data "aws_ssm_parameter" "stack_name_regex" {
  name = "/elasticbeanstalk-stack/${var.environment}/stack_name_regex"
}

# Retrieves the instance port from SSM Parameter Store
data "aws_ssm_parameter" "instance_port" {
  name = "/elasticbeanstalk-stack/${var.environment}/instance_port"
}

# Retrieves the health reporting system conf from SSM Parameter Store
data "aws_ssm_parameter" "health_reporting_system" {
  name = "/elasticbeanstalk-stack/${var.environment}/health_reporting_system"
}

# Retrieves cloudwatch logs flag from SSM Parameter Store
data "aws_ssm_parameter" "enable_cloudwatch_logs" {
  name = "/elasticbeanstalk-stack/${var.environment}/enable_cloudwatch_logs"
}

# Retrieves delete cloudwatch logs flag from SSM Parameter Store
data "aws_ssm_parameter" "delete_logs_on_termination" {
  name = "/elasticbeanstalk-stack/${var.environment}/delete_logs_on_termination"
}

# Retrieves the ALB health check value from SSM Parameter Store
data "aws_ssm_parameter" "alb_health_check_location" {
  name = "/elasticbeanstalk-stack/${var.environment}/alb_health_check_location"
}

# Retrieves the EB solution stack id based of a regex
data "aws_elastic_beanstalk_solution_stack" "multi_docker" {
  most_recent = true

  name_regex = "${data.aws_ssm_parameter.stack_name_regex.value}"
}

# Create the template file to send to EB
data "template_file" "dockerrun" {
  template = "${file("Dockerrun.aws.json")}"

  vars {
    region        = "${var.region}"
    instance_port = "${data.aws_ssm_parameter.instance_port.value}"
    image_tag     = "${data.aws_ssm_parameter.image_tag.value}"
  }
}

# Retrieves VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/landing-zone/${var.environment}/vpc_id"
}

# Retrieves private subnet ids list from SSM Parameter Store
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/landing-zone/${var.environment}/private_subnet_ids"
}

# Retrieves public subnet ids list from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/landing-zone/${var.environment}/public_subnet_ids"
}
