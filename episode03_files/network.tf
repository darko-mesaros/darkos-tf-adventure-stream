# --- networking ---

data "aws_availability_zones" "available" {}

## VPC
resource "aws_vpc" "tfVPC" {
  cidr_block ="10.0.0.0/16"

  tags = {
    Name = "${var.environment}_TFVPC"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.tfVPC.id

  tags = {
    Name = "main"
  }
}

## Subnets
resource "aws_subnet" "public_subnet" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id =  aws_vpc.tfVPC.id
  cidr_block = "10.0.${10+count.index}.0/24" # 10.0.100.0
  availability_zone = element(data.aws_availability_zones.available.names, count.index) #"eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

## Route Table
resource "aws_route_table" "TFRouteTable" {
  vpc_id = aws_vpc.tfVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = {
    Name = "main"
  }
}

## Route Table Association Public
resource "aws_route_table_association" "rtassoc_public" {
  count = length(data.aws_availability_zones.available.names)

  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.TFRouteTable.id
}

## Security Group ALB
resource "aws_security_group" "allow_http" {
  name        = "${var.environment}_allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.tfVPC.id

  ingress {
    description = "HTTP from the Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}_allow_http"
  }
}

## Security Group Instances
resource "aws_security_group" "allow_http_asg" {
  name        = "${var.environment}_allow_http_asg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.tfVPC.id

  ingress {
    description = "HTTP from the Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}_allow_http_asg"
  }
}
