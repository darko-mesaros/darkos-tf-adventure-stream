output "instance_pub_ip" {
  value = aws_instance.myTerraFormInstance.public_ip
}
