# AWS Elastic Beanstalk terraform stack for elasticbeanstalk-exporter.

This terraform stack aims at testing the elasticbeanstalk-exporter developped in the following [repository](https://github.com/jeremietharaud/elasticbeanstalk-exporter).

It deploys a multi-container Docker platform ECS cluster with an EC2 instance and a task definition based on `Dockerrun.aws.json`).

## Pre-requisite

A remote backend has been configured in `aws.tf` for using Terraform Cloud or Terraform Enterprise. The section can be modified or removed to use another backend.

Exemple of remote backend configuration:
```
hostname = "app.terraform.io"
organization = "myorga"
token = "my.api.token"
workspaces = [{name = "my-application"}]
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | Region to deploy the stack | string | `eu-west-3` | yes |
| environment | Name of the environment to retrieve parameters in Parameter Store | string |  | yes |
| application_name | Name of the application | string | `elasticbeanstalk-exporter` | yes |
| stack_name_regex | Regex of the stack name to retrieve | string | `^64bit Amazon Linux (.*) Multi-container Docker (.*)$` | yes |
| instance_type | Instance type used to run the application | string | `t3.small` | yes |
| instance_port | Port used by the container | string | `9552` | yes |
| health_reporting_system | Type of health reporting system: basic or enhanced | string | `enhanced` | yes |
| image_tag | Version of the application to deploy on Elastic Beanstalk Environment | string | `latest` | yes |
| enable_cloudwatch_logs | Whether to create groups in CloudWatch Logs for proxy and deployment logs | string | `true` | yes |
| delete_logs_on_termination | Whether to delete the log groups when the environment is terminated. | string | `true` | yes |
| tags | Tags of the application | map | `{ "Application" = "elasticbeanstalk-exporter" }` | yes |