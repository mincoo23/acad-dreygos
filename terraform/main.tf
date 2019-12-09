provider "aws" {
    region = var.region
}

resource "aws_vpc" "acad-dreygosi-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
        Name = "${var.prefix}-vpc"
        Creator = var.creator
    }
}

resource "aws_subnet" "acad-dreygosi-subnet" {
  vpc_id = "${aws_vpc.acad-dreygosi-vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-subnet"
    Creator = var.creator
  }
}

resource "aws_internet_gateway" "acad-dreygosi-igw" {
  vpc_id = "${aws_vpc.acad-dreygosi-vpc.id}"

  tags = {
    Name = "${var.prefix}-igw"
    Creator = var.creator
  }
}
