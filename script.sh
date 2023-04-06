#! /bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo wget "C:r\Users\baca\Desktop\csis1430" | sudo tee /var/www/html/index.html