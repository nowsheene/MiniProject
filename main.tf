provider "aws" {
    region = "eu-north-1"  
}

resource "aws_instance" "centos_instance" {
  ami           = "ami-0483db98bd5d1c5d1"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name        = aws_key_pair.key_pair.key_name
  tags = {
    Name = "c8.local"
  }
  connection {
      type     = "ssh"
      user     = "cloud-user"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
  }

 
 provisioner "remote-exec" {
   inline = [
     "sudo hostnamectl set-hostname 'c8.local'",
   ]
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-07a0715df72e58928"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name        = aws_key_pair.key_pair.key_name
  tags = {
    Name = "u22.local"
  }
 
 connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
  }

 provisioner "remote-exec" {
   inline = [
     "sudo hostnamectl set-hostname 'u22.local'",
   ]
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow all traffic to inbound and outbound"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "key_pair" {
  key_name   = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_eip" "centos_eip"{
  domain = "vpc"
  instance = aws_instance.centos_instance.id
}

resource "aws_eip" "ubuntu_eip"{
  domain = "vpc"
  instance = aws_instance.ubuntu_instance.id
}

resource "local_file" "host" {
  filename = "/etc/hosts"
  content = <<-EOT
    ${aws_instance.centos_instance.private_ip} ${aws_instance.centos_instance.tags.Name}
    ${aws_instance.ubuntu_instance.private_ip} ${aws_instance.ubuntu_instance.tags.Name}
  EOT
} 
resource "local_file" "ansible" {
  filename = "/opt/infrastructure-pipeline/inventory"
  content = <<-EOT
    [frontend]
    ${aws_instance.centos_instance.tags.Name} ansible_user=cloud-user
    
    [backend]
    ${aws_instance.ubuntu_instance.tags.Name} ansible_user=ubuntu
  EOT
}
