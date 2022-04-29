provider "aws" {
  access_key = "AKIARI2KGH5WZNBIRSOT"
  secret_key = "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"
  region = "us-west-1"
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
  ami           = "ami-09625adacc474a7b4"
  key_name = "keypair1"
  instance_type = "t2.micro"
  security_groups= [ "security_port"]
  tags= {
    Name = "instance1"
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

