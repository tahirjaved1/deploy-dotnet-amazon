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

    user_data = <<-EOF
            # Install Docker
            sudo apt update
            sudo apt install docker.io -y

            # Start and enable Docker service
            sudo systemctl start docker
            sudo systemctl enable docker

            # Add the current user to the docker group to run Docker commands without sudo
            sudo usermod -aG docker $USER
            sudo chown $USER:docker /var/run/docker.sock

            # Install Docker Compose
            sudo apt install docker-compose -y

            # Save the Docker Compose content to a file
            echo "version: '3'

            services:
              sonarqube:
                image: sonarqube:latest
                ports:
                  - \"9000:9000\"
                networks:
                  - sonar-network
                environment:
                  - SONARQUBE_JDBC_URL=jdbc:postgresql://sonarqube-db:5432/sonarqube
                  - SONARQUBE_JDBC_USERNAME=sonaruser
                  - SONARQUBE_JDBC_PASSWORD=yourpassword
                depends_on:
                  - sonarqube-db

              sonarqube-db:
                image: postgres:latest
                networks:
                  - sonar-network
                environment:
                  - POSTGRES_USER=sonaruser
                  - POSTGRES_PASSWORD=yourpassword

            networks:
              sonar-network:
                driver: bridge" > docker-compose.yml

            # Run Docker Compose
            docker-compose up -d

            # Open port 9000 in the firewall
            sudo ufw allow 9000/tcp

            # Display Docker version and running containers
            docker version
            docker ps -a
    EOF
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

  # user_data = <<-EOF
  #             #!/bin/bash
  #             sudo apt update
  #             sudo apt install openjdk-8-jdk -y
              
  #             # Create a directory for Nexus installation
  #             sudo mkdir -p /opt/nexus

  #             # Download Nexus
  #             wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

  #             # Extract Nexus to the installation directory
  #             sudo tar -zxvf latest-unix.tar.gz -C /opt/nexus

  #             # Rename the Nexus directory (replace '3.x.x-xx' with the actual version number)
  #             sudo mv /opt/nexus/nexus-3.x.x-xx /opt/nexus/nexus

  #             # Create a Nexus user and group
  #             sudo groupadd nexus
  #             sudo useradd -c "Nexus Repository Manager" -d /opt/nexus -g nexus nexus

  #             # Change ownership of the Nexus directory
  #             sudo chown nexus:nexus -R /opt/nexus

  #             # Create a systemd service unit file for Nexus
  #             cat <<EOT | sudo tee /etc/systemd/system/nexus.service
  #             [Unit]
  #             Description=Nexus Repository Manager
  #             After=network.target

  #             [Service]
  #             Type=forking
  #             LimitNOFILE=65536
  #             ExecStart=/opt/nexus/bin/nexus start
  #             ExecStop=/opt/nexus/bin/nexus stop
  #             User=nexus
  #             Restart=on-abort
  #             Environment="INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64"  # Adjust the path as necessary

  #             [Install]
  #             WantedBy=multi-user.target
  #             EOT

  #             # Reload systemd to recognize the new service unit file
  #             sudo systemctl daemon-reload

  #             # Enable Nexus to start on boot
  #             sudo systemctl enable nexus.service

  #             # Start the Nexus service
  #             sudo systemctl start nexus.service
  #             EOF

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
