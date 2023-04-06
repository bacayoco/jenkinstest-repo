resource "aws_security_group" "jenkins_sg" {
  name        = "bacajenkins"
  description = "Allow traffic on port 80"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    description = "Allow traffic on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow traffic on port 443"
    from_port   = 22
    to_port     = 22
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
    Name = "bacajenkins"
  }
}