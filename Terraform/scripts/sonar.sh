#!/bin/bash

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
sudo docker-compose up -d

# Open port 9000 in the firewall
sudo ufw allow 9000/tcp

# Display Docker version and running containers
sudo docker version
sudo docker ps -a
