resource "aws_key_pair" "admin_key" {
  key_name   = "admin"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXCBqEBLeqyohA4hvEdDeuTf6cuj8J4w9qunOLLzZb1dwPKOpxAAbW4LoAWjnKAgVfAL3yWe/AGoUOUKQL6ZH/rIMU3AOh7JNqA9vd2G335PJ9yjT2O+W66uVEz0/3Q1ksm79HrE3OjsiShYc3GopT0BYM7xyD+HQF5j/xMnpQoLOUKpQIi9cGQBdHvg20eVfB9e4I2v3vBXZRpLufbDqTP2XHVaCeArODiTw9k0/2DfX5VL8XytaAJnEvBUsVxghhwUKLvqndTfIuiiguo13RvJrOVSWYFjHH7+ryw+dFgiK7jtkYhvI9NxatHyN5DVblzOxhZZlMHlrAhOB519sg1AlHsTQ5duY0ELBWycIpu5pO0XsQKZmTDZqZn/iA0/+ID3eg6C+rGtW1aBvzVDlPfD6mQvd0kVwafFN0rZ9SnM6Aw6crQFyMDfNXl9jUukIvxkJLbC6dxrsGttjewLTgCqcu6WSLFoozCSyuBuTWqke+Caik/ZaygtsGVglDQDc= alexandre@alexandrenubios.lan"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.nginx_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
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
    Name = "allow_http"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.nginx_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_ssh"
  }
}