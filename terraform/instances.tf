resource "aws_instance" "acad-dreygosi-ec2-instance" {
  ami                         = data.aws_ami.acad-dreygosi-ami.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.acad-dreygosi-subnet.id
  associate_public_ip_address = true

  tags = {
    Name    = "${var.prefix}-ec2-instance"
    Creator = var.creator
  }
}

data "aws_ami" "acad-dreygosi-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
