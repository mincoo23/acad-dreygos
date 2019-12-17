resource "aws_instance" "acad-dreygosi-ec2-instance" {
  count                       = 3
  ami                         = data.aws_ami.acad-dreygosi-ami.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.acad-dreygosi-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.acad-dreygosi-sg.id]
  # key_name                    = module.acad-dreygosi-dynamic-keys.key_name
  user_data                   = "${data.template_file.user_data.rendered}"

  # connection {
  #   user        = "ubuntu"
  #   private_key = module.acad-dreygosi-dynamic-keys.private_key_pem
  #   host        = self.public_ip
  # }

  # provisioner "file" {
  #   source      = "../index.html"
  #   destination = "/var/www/html"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt update -y",
  #     "sudo apt install apache2 -y",
  #     "sudo systemctl start apache2"
  #   ]
  # }

  tags = {
    Name    = "${var.prefix}-ec2-instance"
    Creator = var.creator
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.tpl")}"
}

# module "acad-dreygosi-dynamic-keys" {
#   source  = "mitchellh/dynamic-keys/aws"
#   version = "2.0.0"
#   path    = "${path.root}/keys"
#   name    = "${var.creator}-key"
# }

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
