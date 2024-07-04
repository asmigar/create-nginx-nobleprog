resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "${var.ssh_key_name}-${var.env}"
  public_key = tls_private_key.this.public_key_openssh

  provisioner "local-exec" {
    command = "mkdir -p ~/.ssh; echo '${tls_private_key.this.private_key_openssh}' > ~/.ssh/${self.key_name}.pem; chmod 400 ~/.ssh/${self.key_name}.pem"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ~/.ssh/${self.key_name}.pem"
  }
}
