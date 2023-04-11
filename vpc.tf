


resource "aws_vpc" "demo_vpc" {
  cidr_block = var.demo_vpc

  tags = {
    Name = "terraform_demo"
  }

}
resource "aws_internet_gateway" "demo_vpc-IGW" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "terraform_demo"
  }
}



resource "aws_route_table_association" "RT-association" {
  subnet_id      = aws_subnet.priv_subnet-1.id
  route_table_id = aws_route_table.RT.id


}

resource "aws_route" "pub-RT" {
  route_table_id         = aws_route_table.RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo_vpc-IGW.id


}


resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "terraform_demo"
  }
}


resource "aws_subnet" "priv_subnet-1" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = var.priv_subnet_cidr
  availability_zone = var.priv_subnet_AZ

  tags = {
    Name = "priv_subnet-1"
  }
}

resource "aws_subnet" "pub_subnet-1" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = var.pub_subnet_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "pub_subnet"
  }
}