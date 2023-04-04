
################################################################
# Create 2 ec2 instances making use of count / for_each block
################################################################
# creating vpc 
resource "aws_vpc" "aws_vpc" {

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "kojitechs-vpc"
  }
} # 

## "RESOURCE_NAME.LOCAL_NAME.DESIRED_ARTR"
resource "aws_subnet" "subnet_1" {

  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_2"
  }
}

# count
resource "aws_instance" "this" {
  count = 2

  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"
  key_name      = data.aws_key_pair.my_key_pair.key_name
  subnet_id     = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id][count.index]
  #  subnet_id = element([aws_subnet.subnet_1.id,aws_subnet.subnet_2.id], count.index)

  tags = {
    Name = "app-${count.index + 1}"
  }
}
