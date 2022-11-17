resource "aws_instance" "nginx_server" {
  ami                    = "ami-02b01316e6e3496d9"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.admin_key.key_name
  subnet_id              = aws_subnet.nginx_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id]
  user_data = file("scripts/install.sh")

  tags = {
    Name = "nginx-server"
  }
}

resource "aws_eip" "nginx_server_eip" {
  instance = aws_instance.nginx_server.id
  vpc      = true

  tags = {
    "Name" = "nginx-eip"
  }
}