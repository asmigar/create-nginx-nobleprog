output "ssh_command_master_node" {
  value       = <<-SSHCOMMAND
  ssh -i ~/.ssh/${aws_key_pair.this.key_name}.pem ec2-user@${aws_instance.nginx[0].public_dns}
  ssh -i ~/.ssh/${aws_key_pair.this.key_name}.pem ec2-user@${aws_instance.nginx[1].public_dns}
  SSHCOMMAND
  description = "ssh command for connecting to the nginx node"
}

output "access_nginx_here" {
  value       = "http://${aws_alb.nginx_lb.dns_name}"
  description = "url to access nginx"
}


