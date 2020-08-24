# --- networking ---

data "aws_availability_zones" "available" {}


## VPC
resource "aws_vpc" "tfVPC" {
  cidr_block ="10.0.0.0/16"

  tags = {
    Name = "TFVPC"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.tfVPC.id

  tags = {
    Name = "main"
  }
}

## Subnet 01
resource "aws_subnet" "public_subnet01" {
  vpc_id =  aws_vpc.tfVPC.id
  cidr_block = "10.0.100.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet01"
  }
}

## Subnet 02
resource "aws_subnet" "public_subnet02" {
  vpc_id =  aws_vpc.tfVPC.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet02"
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

## Route Table Association 01
resource "aws_route_table_association" "RTTFAssoc01" {
  subnet_id = aws_subnet.public_subnet01.id
  route_table_id = aws_route_table.TFRouteTable.id
}

## Route Table Association 02
resource "aws_route_table_association" "RTTFAssoc02" {
  subnet_id = aws_subnet.public_subnet02.id
  route_table_id = aws_route_table.TFRouteTable.id
}

## Security Group ALB
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
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
    Name = "allow_http"
  }
}

## Security Group Instances
resource "aws_security_group" "allow_http_asg" {
  name        = "allow_http_asg"
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
    Name = "allow_http_asg"
  }
}
