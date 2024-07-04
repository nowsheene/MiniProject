provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "c8.local" {
  ami           = "ami-0483db98bd5d1c5d1"
  instance_type = "t3.micro "
}
