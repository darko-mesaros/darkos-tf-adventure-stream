output "alb_dns" {
  #value = aws_instance.myTerraFormInstance.public_ip
  value = aws_lb.tf-webapp-lb.dns_name
}
