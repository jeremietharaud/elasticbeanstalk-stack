###############################################################
# IAM: Role and policies used by Elastic Beanstalk Environments
###############################################################

# Service role used to perform actions on the environment
# See https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-servicerole.html#iam-servicerole-create
resource "aws_iam_instance_profile" "beanstalk_service" {
  name = "beanstalk-service-role"
  role = "${aws_iam_role.beanstalk_service.name}"
}

# Instance role used to pass role information to EC2 instances
# See https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-instanceprofile.html
resource "aws_iam_instance_profile" "beanstalk_ec2" {
  name = "beanstalk-ec2-user"
  role = "${aws_iam_role.beanstalk_ec2.name}"
}

resource "aws_iam_role" "beanstalk_service" {
  name                 = "beanstalk-service-role"
  permissions_boundary = "${var.boundary_name != "" ? local.permissions_boundary : ""}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "elasticbeanstalk"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role" "beanstalk_ec2" {
  name                 = "beanstalk-ec2-role"
  permissions_boundary = "${var.boundary_name != "" ? local.permissions_boundary : ""}"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "beanstalk_service" {
  name       = "elastic-beanstalk-service"
  roles      = ["${aws_iam_role.beanstalk_service.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

resource "aws_iam_policy_attachment" "beanstalk_service_health" {
  name       = "elastic-beanstalk-service-health"
  roles      = ["${aws_iam_role.beanstalk_service.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_policy_attachment" "beanstalk_ec2_worker" {
  name       = "elastic-beanstalk-ec2-worker"
  roles      = ["${aws_iam_role.beanstalk_ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_policy_attachment" "beanstalk_ec2_web" {
  name       = "elastic-beanstalk-ec2-web"
  roles      = ["${aws_iam_role.beanstalk_ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "beanstalk_ec2_container" {
  name       = "elastic-beanstalk-ec2-container"
  roles      = ["${aws_iam_role.beanstalk_ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_policy" "beanstalk_ec2_beanstalk" {
  name = "elastic-beanstalk-ec2-beanstalk"
  path = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "elasticbeanstalk:Check*",
                "elasticbeanstalk:Describe*",
                "elasticbeanstalk:List*",
                "elasticbeanstalk:RequestEnvironmentInfo",
                "elasticbeanstalk:RetrieveEnvironmentInfo"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "beanstalk_ec2_beanstalk" {
  name       = "elastic-beanstalk-ec2-container"
  roles      = ["${aws_iam_role.beanstalk_ec2.id}"]
  policy_arn = "${aws_iam_policy.beanstalk_ec2_beanstalk.arn}"
}
