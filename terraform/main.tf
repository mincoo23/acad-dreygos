provider "aws" {
    region = var.region
}

resource "aws_vpc" "acad-dreygos-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
        Name = "${var.prefix}-vpc"
        Creator = var.creator
    }
}
