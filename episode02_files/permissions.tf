# --- permissions ---
data "aws_iam_policy" "ssm_ec2_managed_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "TFSSMRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2ssm_role_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = data.aws_iam_policy.ssm_ec2_managed_policy.arn
}

resource "aws_iam_instance_profile" "ec2ssm_instance_profile" {
  name = "ec2_profile_for_ssm"
  role = aws_iam_role.ec2_ssm_role.name
}
