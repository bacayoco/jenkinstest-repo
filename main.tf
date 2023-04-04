resource "aws_vpc" "aws_waf_vpc" {
  cidr_block = local.vpc_cidr
  tags = {
    Name = "waf-demo"
  }
}


resource "aws_subnet" "pubic_waf_subnet" {
  count      = 2
  vpc_id     = aws_vpc.aws_waf_vpc.id
  cidr_block = var.pubic_waf_subnet[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "waf-demo"
  }
}

resource "aws_subnet" "private_waf_subnet" {
  vpc_id     = aws_vpc.aws_waf_vpc.id
  cidr_block = var.private_waf_subnet

  tags = {
    Name = "waf-demo-private"
  }
}
resource "aws_internet_gateway" "waf_igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "waf-demo"
  }
}

resource "aws_route_table" "waf-route-table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.waf_igw.id
  }


  tags = {
    Name = "waf-demo"
  }
}

resource "aws_route_table_association" "waf_rt-association" {
  count = 2
  subnet_id      = aws_subnet.pubic_waf_subnet.*.id[count.index]
    route_table_id = aws_route_table.waf-route-table.id

}


resource "aws_security_group" "alb-SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.aws_waf_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}



# resource "aws_instance" "waf-instance" {
#   instance_type = var.instance_type_web
#   security_groups = [aws_security_group.alb-SG.id]
#   subnet_id         = aws_subnet.pubic_waf_subnet[0].id
#   user_data = <<EOF
# 		#!/bin/bash
# 		yum update -y
# 		yum install -y httpd.x86_64
# 		systemctl start httpd.service
# 		systemctl enable httpd.service
# 		echo ?Hello World from $(hostname -f)? > /var/www/html/index.html
# 	EOF



# }

