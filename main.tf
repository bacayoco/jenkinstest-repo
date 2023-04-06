resource "aws_instance" "wep_pub_demo" {
  ami                       = "ami-0b0dcb5067f052a63"
  instance_type             = "t2.micro"
  vpc_security_group_ids    =  [aws_security_group.jenkins_sg.id]       
  subnet_id = aws_subnet.pub_subnet-1.id
  user_data = "${file("script.sh")}"
  
}

