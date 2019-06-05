resource "aws_s3_bucket" "bucket" {
  bucket = "elasticbeanstalk-${var.region}-elasticbeanstalk-stack"
}

resource "aws_s3_bucket_object" "bucket_object" {
  bucket  = "${aws_s3_bucket.bucket.id}"
  key     = "Dockerrun.aws.json"
  content = "${data.template_file.dockerrun.rendered}"
}

resource "aws_elastic_beanstalk_application" "elasticbeanstalk_exporter" {
  name        = "${var.application_name}"
  description = "Container used to export elasticbeanstalk metrics"
}

resource "aws_elastic_beanstalk_application_version" "latest" {
  name        = "${var.image_tag}"
  application = "${aws_elastic_beanstalk_application.elasticbeanstalk_exporter.name}"
  bucket      = "${aws_s3_bucket.bucket.id}"
  key         = "${aws_s3_bucket_object.bucket_object.id}"
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = "${var.application_name}"
  application         = "${aws_elastic_beanstalk_application.elasticbeanstalk_exporter.name}"
  solution_stack_name = "${data.aws_elastic_beanstalk_solution_stack.multi_docker.name}"
  tier                = "WebServer"
  version_label       = "${aws_elastic_beanstalk_application_version.latest.name}"

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "${aws_iam_instance_profile.beanstalk_service.name}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Rolling"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${data.aws_ssm_parameter.vpc_id.value}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${data.aws_ssm_parameter.private_subnet_ids.value}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${data.aws_ssm_parameter.public_subnet_ids.value}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.instance_type}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.beanstalk_ec2.name}"
  }

  setting {
    namespace = "aws:elbv2:listener:default"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = "false"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "${local.healthcheck_location}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = "${var.instance_port}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "${var.health_reporting_system}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "${var.enable_cloudwatch_logs}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = "${var.delete_logs_on_termination}"
  }

  tags = "${var.tags}"
}
