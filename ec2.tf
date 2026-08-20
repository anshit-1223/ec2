##DEFAULT VPC
resource "aws_default_vpc" "default" {

}

##KEY PAIRS
resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-key-pair"
  public_key = file("ec2-keypair.pub")

}

##SECURITY GROUP
resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  description = "Security Group for EC2"
  vpc_id      = aws_default_vpc.default.id

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

  tags = {
    Name = "EC2_Security_Group"
  }
}

##EC2 CREATION
resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.ec2_key.key_name
  security_groups = [aws_security_group.sg_ec2.name]
  instance_type   = "t2.micro"
  ami             = "ami-01a00762f46d584a1"
  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "my-webserver"
  }
}

