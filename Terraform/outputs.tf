# Output the ID of the VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

# Output the ID of the subnet
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.my_subnet.id
}

# Output the public IP address of the SonarQube EC2 instance
output "public_ip_sonarqube" {
  description = "Public IP address of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube_instance.public_ip
}

# Output the public IP address of the Nexus EC2 instance
output "public_ip_nexus" {
  description = "Public IP address of the Nexus EC2 instance"
  value       = aws_instance.nexus_instance.public_ip
}

# Output the public IP address of the Deployment EC2 instance
output "public_ip_deployment" {
  description = "Public IP address of the Deployment EC2 instance"
  value       = aws_instance.deployment_instance.public_ip
}

# Output the ID of the SonarQube EC2 instance
output "sonarqube_instance_id" {
  description = "The ID of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube_instance.id
}

# Output the ID of the Nexus EC2 instance
output "nexus_instance_id" {
  description = "The ID of the Nexus EC2 instance"
  value       = aws_instance.nexus_instance.id
}

# Output the ID of the Deployment EC2 instance
output "deployment_instance_id" {
  description = "The ID of the Deployment EC2 instance"
  value       = aws_instance.deployment_instance.id
}

# Output the public IP URL for SonarQube instance
output "sonarqube_public_ip" {
  value = "http://${aws_instance.sonarqube_instance.public_ip}:9000"
  description = "Public IP URL for SonarQube instance"
}

# Output the public IP for SonarQube instance
output "sonarqube_public_ip_ssh" {
  value = aws_instance.sonarqube_instance.public_ip
  description = "Public IP for SonarQube instance"
}

# Output the public IP URL for Nexus instance
output "nexus_public_ip" {
  value = "http://${aws_instance.nexus_instance.public_ip}:8081"
  description = "Public IP URL for Nexus instance"
}

# Output the public IP for Nexus instance
output "nexus_public_ip_ssh" {
  value = aws_instance.nexus_instance.public_ip
  description = "Public IP for Nexus instance"
}

# Output the public IP for Deployment instance
output "deployment_instance_public_ip" {
  value = aws_instance.deployment_instance.public_ip
  description = "Public IP for Deployment instance"
}

# Output the public IP URL for Deployment instance
output "deployment_public_url" {
  value = "http://${aws_instance.deployment_instance.public_ip}:8080/swagger/index.html"
  description = "Public IP URL for Deployment"
}

# Output the name of the Deployment instance
output "deployment_instance_name" {
  value = aws_instance.deployment_instance.tags.Name
}

# Output the private key
output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true # Mark the private key as sensitive
}
