locals {
  tags = {
    "Environment" = "${data.aws_ssm_parameter.environment.value}"
    "Application" = "D2SI"
    "Stack"       = "https://github.com/jeremietharaud/elasticbeanstalk-stack"
  }
}
