resource "aws_security_group" "allow_ssh" {
  name        = module.dev_nobleprog_alpha.id
  description = "Allow TLS inbound traffic"
  vpc_id      = module.aws_networks.vpc_id

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "nginx"
  }
}


resource "aws_vpc_security_group_ingress_rule" "ssh_sg_ingress" {
  security_group_id            = aws_security_group.allow_ssh.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  cidr_ipv4 = "152.59.173.15/32"
  description = "Sagar public ip"
}

resource "aws_vpc_security_group_ingress_rule" "lb_sg_ingress" {
  security_group_id            = aws_security_group.allow_ssh.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.lb_sg.id
}