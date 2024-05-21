output "access_nginx_here" {
  value       = "http://${aws_alb.nginx_lb.dns_name}"
  description = "url to access nginx"
}


