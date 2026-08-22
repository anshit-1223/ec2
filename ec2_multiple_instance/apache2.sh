#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl enable --now apache2
echo "<h1>EC2 Instance created via Terraform</h1>" | sudo tee /var/www/html/index.html