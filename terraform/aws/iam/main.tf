variable "short_name" {default = "pubsub"}

resource "aws_iam_instance_profile" "pubsub_profile" {
  name = "${var.short_name}-pubsub-profile"
  roles = ["${aws_iam_role.pubsub_role.name}"]
}

resource "aws_iam_role_policy" "pubsub_policy" {
  name = "${var.short_name}-pubsub-policy"
  role = "${aws_iam_role.pubsub_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["route53:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "pubsub_role" {
  name = "${var.short_name}-pubsub-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

output "pubsub_iam_instance_profile" {
  value = "${aws_iam_instance_profile.pubsub_profile.name}"
}