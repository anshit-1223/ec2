output "public_ip" {
    value = aws_instance.my_instance.public_ip
  
}

output "public_dns" {
    value = aws_instance.my_instance.public_dns
}

output "instance_username" {
    value = "ubuntu"
}

