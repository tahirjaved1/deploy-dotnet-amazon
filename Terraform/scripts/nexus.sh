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

# Create a Docker Compose file for Nexus
echo "version: '3'

services:
  nexus:
    image: sonatype/nexus3:latest
    ports:
      - \"8081:8081\"
    networks:
      - nexus-network
    volumes:
      - ./nexus-data:/nexus-data
    restart: always  # Ensure the container restarts automatically
    environment:
      - MAX_HEAP=2048m  # Set maximum heap size
    command: bash -c \"export MAX_HEAP=\$MAX_HEAP && /opt/sonatype/start-nexus-repository-manager.sh\"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    mem_limit: 4096m  # Set the container memory limit to 4096 MB

networks:
  nexus-network:
    driver: bridge" > docker-compose.yml

# Create a volume for Nexus data
mkdir -p nexus-data

# Set proper permissions for the Nexus data directory
sudo chown -R 200:200 nexus-data

# Run Docker Compose to start Nexus
sudo docker-compose up -d

# Open port 8081 in the firewall
sudo ufw allow 8081/tcp

# Display Docker version and running containers
sudo docker version
sudo docker ps -a
