data "aws_caller_identity" "current" {}

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
