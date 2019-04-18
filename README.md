# AWS Elastic Beanstalk terraform stack for elasticbeanstalk-exporter.

This terraform stack aims at testing the elasticbeanstalk-exporter developped in the following [repository](https://github.com/jeremietharaud/elasticbeanstalk-exporter).

It deploys a multi-container Docker platform ECS cluster with an EC2 instance and a task definition based on `Dockerrun.aws.json`).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | Region to deploy the stack | string | `eu-west-3` | yes |
| boundary_name | Name of the permissions boundary for creating roles | string |  | no |
| application_name | Name of the application | `elasticbeanstalk-exporter` | string | yes |
| stack_name_regex | Regex of the stack name to retrieve | string | `^64bit Amazon Linux (.*) Multi-container Docker (.*)$` | yes |
| instance_port | Port used by the container | string | `9552` | yes |
| health_reporting_system | Type of health reporting system: basic or enhanced | string | `euhanced` | yes |
| enable_cloudwatch_logs | Whether to create groups in CloudWatch Logs for proxy and deployment logs | string | `true` | yes |
| delete_logs_on_termination | Whether to delete the log groups when the environment is terminated. | string | `true` | yes |
| tags | Tags of the application | `"Application" = "elasticbeanstalk-exporter"` | string | yes |