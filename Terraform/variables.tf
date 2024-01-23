variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "The name of the SSH key pair."
  type        = string
  // No default provided; should be specified in terraform.tfvars or at runtime
}

variable "sonarqube_ami" {
  description = "The AMI ID for the SonarQube EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "nexus_ami" {
  description = "The AMI ID for the Nexus EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "deployment_ami" {
  description = "The AMI ID for the Deployment EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}
