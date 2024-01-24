resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    # SonarQube
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Nexus
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "sonarqube_instance" {
  ami                    = var.sonarqube_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "SonarQube"
  }
}

resource "aws_instance" "nexus_instance" {
  ami                    = var.nexus_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "Nexus"
  }
}

resource "aws_instance" "deployment_instance" {
  ami                    = var.deployment_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.generated_key.key_name

  tags = {
    Name = "Deployment"
  }
}
