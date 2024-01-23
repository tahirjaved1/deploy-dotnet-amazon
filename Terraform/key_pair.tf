resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "test-${var.aws_region}"
  public_key = tls_private_key.example.public_key_openssh

  tags = {
    Name = "test-${var.aws_region}"
  }
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/test-${var.aws_region}.pem"
}
