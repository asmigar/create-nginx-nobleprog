resource "aws_security_group" "lb_sg" {
  vpc_id = module.aws_networks.vpc_id

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


resource "aws_alb" "nginx_alb" {
  name               = module.nobleprog_alpha.id
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = module.aws_networks.subnet_ids

  enable_deletion_protection = false

}

resource "aws_alb_target_group" "nginx" {
  name     = module.nobleprog_alpha.id
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.aws_networks.vpc_id
}

resource "aws_autoscaling_attachment" "nginx" {
  autoscaling_group_name = aws_autoscaling_group.nginx.id
  lb_target_group_arn    = aws_alb_target_group.nginx.arn
}

resource "aws_alb_listener" "nginx_lb" {
  load_balancer_arn = aws_alb.nginx_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.nginx.arn
  }
}