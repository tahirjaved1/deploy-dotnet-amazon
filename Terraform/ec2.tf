# Create a security group to allow SSH and specific ports for SonarQube and Nexus
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  # Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SonarQube traffic
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Nexus traffic
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create SonarQube EC2 instance
resource "aws_instance" "sonarqube_instance" {
  ami                    = var.sonarqube_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = base64encode(file("${path.module}/scripts/sonar.sh"))

  tags = {
    Name = "SonarQube"
  }
}


# Create Nexus EC2 instance
resource "aws_instance" "nexus_instance" {
  ami                    = var.nexus_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = base64encode(file("${path.module}/scripts/nexus.sh"))

  tags = {
    Name = "Nexus"
  }
}


# Create Deployment EC2 instance
resource "aws_instance" "deployment_instance" {
  ami                    = var.deployment_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.generated_key.key_name

  tags = {
    Name = "Deployment"
  }
}
