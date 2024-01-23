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

    # user_data = <<-EOF
    #         #!/bin/bash

    #         # Update and install necessary packages
    #         sudo apt update
    #         sudo apt install -y openjdk-11-jdk unzip

    #         # Download SonarQube
    #         wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.0.43852.zip -O sonarqube.zip

    #         # Unzip and move SonarQube
    #         sudo unzip sonarqube.zip -d /opt
    #         sudo mv /opt/sonarqube-8.9.0.43852 /opt/sonarqube

    #         # Check if group/user already exists, if not, create them
    #         if ! getent group sonar > /dev/null; then
    #           sudo groupadd sonar
    #         fi
    #         if ! getent passwd sonar > /dev/null; then
    #           sudo useradd -c "SonarQube" -d /opt/sonarqube -g sonar sonar
    #         fi

    #         # Change ownership of the SonarQube directory
    #         sudo chown sonar:sonar /opt/sonarqube -R

    #         # Configure SonarQube
    #         echo "sonar.jdbc.username=sonar" | sudo tee -a /opt/sonarqube/conf/sonar.properties
    #         echo "sonar.jdbc.password=sonar" | sudo tee -a /opt/sonarqube/conf/sonar.properties
    #         echo "sonar.jdbc.url=jdbc:h2:tcp://localhost:9092/sonar" | sudo tee -a /opt/sonarqube/conf/sonar.properties

    #         # Start SonarQube
    #         sudo -u sonar /opt/sonarqube/bin/linux-x86-64/sonar.sh start
    # EOF

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
