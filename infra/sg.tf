resource "terraform_data" "my_ip" {
  triggers_replace = timestamp()

  provisioner "local-exec" {
    command = "curl -4 ifconfig.me > /tmp/my_ip.txt"
  }
}

data "local_file" "my-ip" {
  filename   = "/tmp/my_ip.txt"
  depends_on = [terraform_data.my_ip]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.local_file.my-ip.content}/32"]
  }

  ingress {
    description     = "lb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "allow_ssh_nginx"
  }

  depends_on = [terraform_data.my_ip]
}
