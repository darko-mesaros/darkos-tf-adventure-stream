resource "aws_lb" "tf-webapp-lb" {
  name               = "${var.environment}-tf-webapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = aws_subnet.public_subnet.*.id

  tags = {
    ENV = var.environment
  }
}

resource "aws_lb_target_group" "tf-webservers" {
  name     = "${var.environment}-tf-webservers"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.tfVPC.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.tf-webapp-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-webservers.arn
  }
}
