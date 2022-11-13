resource "aws_vpc" "nginx_vpc" {
  cidr_block = "170.10.0.0/16"

  tags = {
    Name = "nginx_sandbox"
  }
}

resource "aws_internet_gateway" "sandbox_main_gw" {
  vpc_id = aws_vpc.nginx_vpc.id
  tags = {
    "Name" = "sandbox-nginx-igw"
  }
}

resource "aws_subnet" "nginx_subnet_1" {
  vpc_id            = aws_vpc.nginx_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.nginx_vpc.cidr_block, 8, 1)
  availability_zone = "eu-west-3a"

  tags = {
    Name = "subnet-nginx-1"
  }
}
resource "aws_subnet" "nginx_subnet_2" {
  vpc_id            = aws_vpc.nginx_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.nginx_vpc.cidr_block, 8, 2)
  availability_zone = "eu-west-3b"

  tags = {
    Name = "subnet-nginx-2"
  }
}

resource "aws_route_table" "nginx_route_table" {
  vpc_id = aws_vpc.nginx_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sandbox_main_gw.id
  }
  tags = {
    "Name" = "internet-route"
  }
}

resource "aws_route_table_association" "subnet_1_sandbox_main_gw" {
  subnet_id      = aws_subnet.nginx_subnet_1.id
  route_table_id = aws_route_table.nginx_route_table.id
}
resource "aws_route_table_association" "subnet_2_sandbox_main_gw" {
  subnet_id      = aws_subnet.nginx_subnet_2.id
  route_table_id = aws_route_table.nginx_route_table.id
}