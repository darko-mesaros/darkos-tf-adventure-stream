provider "aws" {
  profile = "default"
  region = var.region
}

# --- compute ---
#resource "aws_instance" "myTerraFormInstance" {
#  ami           = "ami-07d9160fa81ccffb5"
#  instance_type = var.instance_type
#  vpc_security_group_ids = [aws_security_group.allow_http.id]
#  subnet_id = aws_subnet.subnet01.id
#  associate_public_ip_address = true
#  user_data = file("userdata.sh")
#  iam_instance_profile = aws_iam_instance_profile.ec2ssm_instance_profile.name
#  tags = {
#    Name = "TFWebServer"
#  }
#}
