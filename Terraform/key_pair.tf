resource "random_string" "keypair_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}


resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "keypair-${var.aws_region}-${random_string.keypair_suffix.result}"
  public_key = tls_private_key.example.public_key_openssh

  tags = {
    Name = "keypair-${var.aws_region}-${random_string.keypair_suffix.result}"
  }
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/keypair-${var.aws_region}-${random_string.keypair_suffix.result}.pem"
}