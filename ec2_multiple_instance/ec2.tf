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
  count           = 2
  key_name        = aws_key_pair.ec2_key.key_name
  security_groups = [aws_security_group.sg_ec2.name]
  instance_type   = var.instance_type
  ami             = var.instance_ami
  user_data = file("apache2.sh")
  root_block_device {
    volume_size = var.instance_size
    volume_type = "gp3"
  }

  tags = {
    Name = "my-webserver"
  }
}

