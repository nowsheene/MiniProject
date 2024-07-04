provider "aws" {
    region = "eu-north-1"  
}

resource "aws_instance" "c8.local" {
  ami           = "ami-0483db98bd5d1c5d1"
  instance_type = "t3.micro "
}

resource "aws_instance" "u22.local" {
  ami           = "ami-07a0715df72e58928"
  instance_type = "t3.micro "
}
