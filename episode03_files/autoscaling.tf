# --- launch template ---
resource "aws_launch_template" "TFWebServers" {
  name_prefix = "${var.environment}_jTFWebServe"
  image_id = "ami-07d9160fa81ccffb5"
  instance_type = var.instance_type
  user_data = filebase64("userdata.sh")
  vpc_security_group_ids = [ aws_security_group.allow_http_asg.id ]
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2ssm_instance_profile.name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      ENV = var.environment
    }
  }
}

# --- autscaling group ---
resource "aws_autoscaling_group" "TFWebServersASG" {
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  vpc_zone_identifier = aws_subnet.public_subnet.*.id
  target_group_arns = [ aws_lb_target_group.tf-webservers.arn ]

  launch_template {
    id      = aws_launch_template.TFWebServers.id
    version = "$Latest"
  }
}
