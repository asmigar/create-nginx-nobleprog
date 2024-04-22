resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    description      = "open to world"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_security_group_egress_rule" "lb_sg_egress" {
  security_group_id            = aws_security_group.lb_sg.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_alb" "nginx_lb" {
  name               = "nginx-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true
}

resource "aws_alb_target_group" "nginx" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_alb_target_group_attachment" "nginx-tg" {
  for_each = {
    for key, value in aws_instance.nginx :
    key => value
  }

  target_group_arn = aws_alb_target_group.nginx.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_alb_listener" "nginx_lb" {
  load_balancer_arn = aws_alb.nginx_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.nginx.arn
  }
}