provider "aws" {
  region = "us-east-1"  
}

resource "aws_vpc" "web_app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "web-app-vpc"
  }
}

resource "aws_subnet" "web_app_public_subnet_1" {
  vpc_id                  = aws_vpc.web_app_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true  

  tags = {
    Name = "web-app-public-subnet-1"
  }
}

resource "aws_subnet" "web_app_public_subnet_2" {
  vpc_id                  = aws_vpc.web_app_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "web-app-public-subnet-2"
  }
}

resource "aws_subnet" "web_app_private_subnet_1" {
  vpc_id                  = aws_vpc.web_app_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "web-app-private-subnet-1"
  }
}

resource "aws_subnet" "web_app_private_subnet_2" {
  vpc_id                  = aws_vpc.web_app_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "web-app-private-subnet-2"
  }
}

resource "aws_instance" "web_app_instance" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.web_app_public_subnet_1.id  

  tags = {
    Name = "web-app-instance"
  }
}

resource "aws_security_group" "web_app_public_sg" {
  name        = "web_app_public_sg"
  description = "Allow SSH and HTTP traffic for public instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_app_private_sg" {
  name        = "web_app_private_sg"
  description = "Allow SSH and HTTP traffic for private instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.web_app_public_sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.web_app_public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
