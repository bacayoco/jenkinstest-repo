terraform {
  backend "s3"{
    bucket = "bacakojibucket"
    region = "us-east-1"
    key    = "vpc/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    
  }
}



data "terraform_remote_state" "vpc"{

    backend = "s3"
    config = {

        bucket = "my-ecs-test-bucket"
        key    = "vpc/terraform.tfstate"
        region = "us-east-1"
    }
}



resource "aws_instance" "wep_pub_demo" {
  ami                       = "ami-0b0dcb5067f052a63"
  instance_type             = "t2.micro"
  vpc_security_group_ids    =  [data.terraform_remote_state.vpc.outputs.security_group]       
  subnet_id = "${data.terraform_remote_state.vpc.outputs.pub-subnet}"
  user_data = "${file("script.sh")}"
  
}


