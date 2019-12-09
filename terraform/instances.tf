resource "aws_instance" "acad-dreygosi-ec2-instance" {
  count                       = 3
  ami                         = data.aws_ami.acad-dreygosi-ami.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.acad-dreygosi-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.acad-dreygosi-sg.id]

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
