variable "instance_ami" {
  default = "ami-01a00762f46d584a1"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "instance_size" {
  default = 15
  type    = number
}