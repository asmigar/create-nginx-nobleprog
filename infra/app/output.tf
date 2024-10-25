output "access_nginx_here" {
  value = "http://${aws_alb.nginx_alb.dns_name}"
}


