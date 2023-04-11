
output "vpc_id" {
    value = "${aws_vpc.demo_vpc.id}"
}

output "priv_subnet-1" {
    value = "${aws_subnet.priv_subnet-1.id}"
}


output "pub_subnet-1" {
    value = "${aws_subnet.pub_subnet-1.id}"
}

output "aws_security_group" {
    value = "${aws_security_group.jenkins_sg.id}"
}
