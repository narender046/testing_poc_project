resource "aws_vpc" "demo_vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = local.common_tags
}

resource "aws_subnet" "subnet1" {
  cidr_block = var.subnets_cidr_block[0]
  vpc_id = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = true
  tags = local.common_tags
}

resource "aws_subnet" "subnet2" {
  cidr_block = var.subnets_cidr_block[1]
  vpc_id = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = true
  tags = local.common_tags
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = local.common_tags
}

resource "aws_route_table" "demo_rtb" {
    vpc_id = aws_vpc.demo_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_igw.id
    }
    tags = local.common_tags
}

resource "aws_route_table_association" "rtb1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.demo_rtb.id
  
}

resource "aws_route_table_association" "rtb2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.demo_rtb.id
  
}

resource "aws_security_group" "web-sg" {
    name = "web-sg"
    vpc_id = aws_vpc.demo_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]  
    }

    tags = local.common_tags
}

resource "aws_security_group" "app-lb-sg" {
    name = "app-lb-sg"
    vpc_id = aws_vpc.demo_vpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags = local.common_tags
}
