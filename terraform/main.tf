provider "aws" {
  region = var.region
}

resource "aws_vpc" "acad-dreygosi-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.prefix}-vpc"
    Creator = var.creator
  }
}

resource "aws_subnet" "acad-dreygosi-subnet" {
  vpc_id                  = "${aws_vpc.acad-dreygosi-vpc.id}"
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.prefix}-subnet"
    Creator = var.creator
  }
}

resource "aws_internet_gateway" "acad-dreygosi-igw" {
  vpc_id = "${aws_vpc.acad-dreygosi-vpc.id}"

  tags = {
    Name    = "${var.prefix}-igw"
    Creator = var.creator
  }
}

resource "aws_route" "acad-dreygosi-route" {
  route_table_id         = aws_vpc.acad-dreygosi-vpc.main_route_table_id
  destination_cidr_block = var.everywhere
  gateway_id             = aws_internet_gateway.acad-dreygosi-igw.id
}

resource "aws_route_table_association" "acad-dreygosi-rt-association" {
  subnet_id      = aws_subnet.acad-dreygosi-subnet.id
  route_table_id = aws_vpc.acad-dreygosi-vpc.main_route_table_id
}

resource "aws_security_group" "acad-dreygosi-elb-sg" {
  description = "Security group for the ELB."
  vpc_id      = aws_vpc.acad-dreygosi-vpc.id

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.own_ip]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.everywhere]
  }

  tags = {
    Name    = "${var.prefix}-elb-sg"
    Creator = var.creator
  }
}

resource "aws_security_group" "acad-dreygosi-ec2-sg" {
  description = "Security group for the instances hosting the web server."
  vpc_id      = aws_vpc.acad-dreygosi-vpc.id

  ingress {
    from_port       = 0
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.acad-dreygosi-elb-sg.id]
  }

  egress {
    from_port       = 80
    to_port         = 0
    protocol        = "tcp"
    security_groups = [aws_security_group.acad-dreygosi-elb-sg.id]
  }

  tags = {
    Name    = "${var.prefix}-ec2-sg"
    Creator = var.creator
  }
}

resource "aws_elb" "acad-dreygosi-elb" {
  name            = "${var.prefix}-elb"
  security_groups = [aws_security_group.acad-dreygosi-elb-sg.id]
  subnets         = [aws_subnet.acad-dreygosi-subnet.id]
  instances       = aws_instance.acad-dreygosi-ec2-instance.*.id

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 5
  }

  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.prefix}-elb"
  }
}
