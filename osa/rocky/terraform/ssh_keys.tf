
resource "random_string" "ssh_key_name" {
  length  = 8
  special = false
}
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "main" {
  key_name   = "${var.stage}-${random_string.ssh_key_name.result}"
  public_key = "${tls_private_key.ssh_key.public_key_openssh}"
}

output "ssh_public_key" {
  value  = "${tls_private_key.ssh_key.public_key_openssh}"
}

output "ssh_private_key" {
  value = "${tls_private_key.ssh_key.private_key_pem}"
}
