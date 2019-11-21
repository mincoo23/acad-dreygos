provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "acad-dreygos-ec2-terraform" {
    ami = "ami-408c7f28"
    instance_type = "t2.micro"
    tags = {
        name = "acad-dreygos-ec2-terraform"
        }
    }
