#! /bin/bash
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user
docker pull nginx:latest
docker run --name nginx-server -p 80:80 -d nginx