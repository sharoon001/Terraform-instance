provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-2"
}


#Create security group with firewall rules
resource "aws_security_group" "security_port" {
  name        = "security_port"
  description = "security group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_port"
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = "ami-0fa49cc9dc8d62c84"
  key_name = "keypair2"
  instance_type = "t2.micro"
  security_groups= [ "security_port"]
  tags= {
    Name = "instance2"
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "elstic_ip1"
  }
}

