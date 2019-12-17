provider "aws" {
  region = var.region
}

resource "aws_vpc" "acad-dreygosi-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.prefix}-vpc"
    Creator = var.creator
  }
}

resource "aws_subnet" "acad-dreygosi-subnet" {
  vpc_id                  = "${aws_vpc.acad-dreygosi-vpc.id}"
  cidr_block              = "10.0.0.0/24"
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
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.acad-dreygosi-igw.id
}

resource "aws_route_table_association" "acad-dreygosi-rt-association" {
  subnet_id      = aws_subnet.acad-dreygosi-subnet.id
  route_table_id = aws_vpc.acad-dreygosi-vpc.main_route_table_id
}

resource "aws_security_group" "acad-dreygosi-sg" {
  name        = "acad-dreygosi-sg"
  description = "Security group for the instances in the public subnet."
  vpc_id      = aws_vpc.acad-dreygosi-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.prefix}-sg"
    Creator = var.creator
  }
}
