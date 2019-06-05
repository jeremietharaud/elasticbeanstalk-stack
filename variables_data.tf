data "aws_elastic_beanstalk_solution_stack" "multi_docker" {
  most_recent = true

  name_regex = "${var.stack_name_regex}"
}

data "template_file" "dockerrun" {
  template = "${file("Dockerrun.aws.json")}"

  vars {
    region        = "${var.region}"
    instance_port = "${var.instance_port}"
    image_tag     = "${var.image_tag}"
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
