output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.my_subnet.id
}

output "public_ip_sonarqube" {
  description = "Public IP address of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube_instance.public_ip
}

output "public_ip_nexus" {
  description = "Public IP address of the Nexus EC2 instance"
  value       = aws_instance.nexus_instance.public_ip
}

output "public_ip_deployment" {
  description = "Public IP address of the Deployment EC2 instance"
  value       = aws_instance.deployment_instance.public_ip
}

output "sonarqube_instance_id" {
  description = "The ID of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube_instance.id
}

output "nexus_instance_id" {
  description = "The ID of the Nexus EC2 instance"
  value       = aws_instance.nexus_instance.id
}

output "deployment_instance_id" {
  description = "The ID of the Deployment EC2 instance"
  value       = aws_instance.deployment_instance.id
}

output "sonarqube_public_ip" {
  value = "http://${aws_instance.sonarqube_instance.public_ip}:9000"
  description = "Public IP URL for SonarQube instance"
}

output "sonarqube_public_ip_ssh" {
  value = aws_instance.sonarqube_instance.public_ip
  description = "Public IP for SonarQube instance"
}

output "nexus_public_ip" {
  value = "http://${aws_instance.nexus_instance.public_ip}:8081"
  description = "Public IP URL for Nexus instance"
}

output "deployment_instance_public_ip" {
  value = aws_instance.deployment_instance.public_ip
  description = "Public IP for Deployment instance"
}

output "deployment_instance_name" {
  value = aws_instance.deployment_instance.tags.Name
}

output "private_key" {
  value = tls_private_key.example.private_key_pem
  sensitive = true
}
