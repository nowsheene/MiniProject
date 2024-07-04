provider "aws" {
    region = "eu-north-1"  
}

resource "aws_instance" "centos_instance" {
  ami           = "ami-0483db98bd5d1c5d1"
  instance_type = "t3.micro"
  tags = {
    Name = "c8.local"
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-07a0715df72e58928"
  instance_type = "t3.micro"
  tags = {
    Name = "u22.local"
  }
}
